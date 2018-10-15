defmodule ForecastProject.Repo.Migrations.ModifyTemperature do
  use Ecto.Migration

  def change do
    alter table(:weather) do
      remove :temperature
      add :temperature, :float
    end
  end
end
