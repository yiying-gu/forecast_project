defmodule ForecastProject.Repo.Migrations.Weather do
  use Ecto.Migration

  def change do
    create table(:weather) do
      add :temperature, :float
      timestamps()
    end
  end
end
