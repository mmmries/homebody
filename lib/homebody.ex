defmodule Homebody do
  use Application
  import Supervisor.Spec, warn: false

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do

    Nerves.SSDPServer.publish(Node.self, service_name)
    :inet_db.set_lookup([:file, :dns]) # prefer host entries to DNS lookup

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Homebody.Supervisor]
    Supervisor.start_link(my_children, opts)
  end

  def service_name, do: "homebody._tcp"

  defp my_children do
    [] |> connector_children |> reporter_children |> blinky_children
  end

  defp connector_children(list) do
    list ++ [worker(Homebody.Connector, [])]
  end

  defp reporter_children(list) do
    case Application.get_env(:homebody, :reporting) do
      nil -> list
      [url: url] -> list ++ [worker(Homebody.Reporter, [url])]
    end
  end

  defp blinky_children(list) do
    if Blinky.start_application? do
      list ++ [
        worker(Blinky.Scheduler, [[name: :scheduler]]),
        worker(Blinky.Gpio, [Application.get_env(Blinky, :keep_sleeping_pin), [name: :keep_sleeping]], id: :keep_sleeping),
        worker(Blinky.Gpio, [Application.get_env(Blinky, :wakeup_pin), [name: :time_to_wakeup]], id: :time_to_wakeup),
      ]
    else
      list
    end
  end
end
