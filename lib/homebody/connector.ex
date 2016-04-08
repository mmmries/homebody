defmodule Homebody.Connector do
  use GenServer
  require Logger
  @check_interval 10_000

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(nil) do
    {:ok, nil, @check_interval}
  end

  def handle_info(:timeout, state) do
    Logger.info "#{__MODULE__} going to discover new nodes (currently connected to #{inspect Node.list}"
    discover_nodes
    |> attempt_to_connect_to_nodes
    {:noreply, state, @check_interval}
  end

  defp attempt_to_connect_to_nodes(nodes) do
    Logger.info "#{__MODULE__} attempting to connect to #{inspect nodes}"
    nodes
    |> Enum.map(&(String.to_atom(&1)))
    |> Enum.each(fn(node) ->
      unless node in [Node.self | Node.list] do
        Node.connect(node)
      end
    end)
  end

  defp discover_nodes do
    Nerves.SSDPClient.discover(target: "beam")
    |> Map.keys
    |> Enum.filter(fn(nil) -> false
                       (_) -> true end)
  end
end
