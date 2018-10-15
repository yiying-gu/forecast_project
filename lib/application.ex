defmodule ForecastProject.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(ForecastProject.Repo, []),
      worker(ForecastProject.Scheduler, [])
    ]

    opts = [strategy: :one_for_one, name: ForecastProject.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
