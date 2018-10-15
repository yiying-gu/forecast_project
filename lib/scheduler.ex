defmodule ForecastProject.Scheduler do
  use GenServer
  alias ForecastProject.GetTemperature
  alias ForecastProject.Repo

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    handle_info(:work, state)
    {:ok, state}
  end

  def handle_info(:work, state) do
    GetTemperature.run() |> Repo.insert
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 60 * 60 * 1000)
  end
end
