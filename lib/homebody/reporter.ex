defmodule Homebody.Reporter do
  use GenServer
  require Logger

  def start_link(url) do
    GenServer.start_link(__MODULE__, url, name: __MODULE__)
  end

  def init(url) do
    :pg2.create(:thermex_measurements)
    :pg2.join(:thermex_measurements, self())
    :timer.send_interval(5_000, :report_measurements)
    {:ok, %{url: url, measurements: []}}
  end

  def handle_info({_, _, _}=measurement, %{measurements: measurements}=state) do
    {:noreply, %{state | measurements: [measurement | measurements]}}
  end

  def handle_info(:report_measurements, %{measurements: []}=state) do
    {:noreply, state}
  end
  def handle_info(:report_measurements, %{url: url, measurements: measurements}=state) do
    body = measurements
           |> Enum.map(&measurement_to_line/1)
           |> Enum.join("\n")
    {:ok, _status_code, _headers, client_ref} = :hackney.request(:post, url, [], body, []) |> IO.inspect
    {:ok, _body} = :hackney.body(client_ref)
    {:noreply, %{state | measurements: []}}
  end

  def handle_info(msg, state) do
    Logger.error("#{__MODULE__} received unexpected message #{inspect msg}")
    {:noreply, state}
  end

  defp measurement_to_line({serial, temperature, timestamp}) do
    "temperature,sensor=#{serial} value=#{temperature} #{timestamp}000000"
  end
end
