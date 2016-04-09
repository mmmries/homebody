defmodule Homebody.Connector do
  use GenServer
  require Logger
  @check_interval 30_000

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(nil) do
    {:ok, nil, @check_interval}
  end

  def handle_info(:timeout, state) do
    discover_nodes
    |> attempt_to_connect_to_nodes
    {:noreply, state, @check_interval}
  end

  defp add_host_entry_for_node(node_name, %{host: ip_addr}) do
    Logger.info "adding host entry for #{node_name} (#{ip_addr})"
    {:ok, ip} = ip_addr |> String.to_char_list |> :inet.parse_ipv4_address
    [_, hostname] = String.split(node_name, "@")
    hostname = String.to_char_list(hostname)
    :ok = :inet_db.add_host(ip, [hostname])
  end

  defp attempt_to_connect_to_nodes(nodes) do
    nodes
    |> Enum.each(fn({node_name, meta}) ->
      node_atom = String.to_atom(node_name)
      unless node_atom in Node.list do
        add_host_entry_for_node(node_name, meta)
        Logger.info "attempting connection to #{node_name}"
        Node.connect(node_atom)
      end
    end)
  end

  defp discover_nodes do
    current_node = Node.self |> Atom.to_string
    Nerves.SSDPClient.discover(target: Homebody.service_name)
    |> Enum.filter(fn({nil,_}) -> false
                      ({^current_node, _}) -> false
                       ({_,_}) -> true end)
  end
end
