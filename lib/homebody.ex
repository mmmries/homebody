defmodule Homebody do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Nerves.SSDPServer.publish(Node.self, service_name)
    :inet_db.set_lookup([:file, :dns]) # prefer host entries to DNS lookup

    children = case Application.get_env(:homebody, :reporting) do
      nil -> [worker(Homebody.Connector, [])]
      [url: url] -> [worker(Homebody.Connector, []), worker(Homebody.Reporter, [url])]
    end

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Homebody.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def service_name, do: "homebody._tcp"
end
