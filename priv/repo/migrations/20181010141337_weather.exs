defmodule ForecastProject.Repo.Migrations.Weather do
  use Ecto.Migration

  def change do
    create table(:weather) do
      add :temperature, :float
      add :updated_at, :string
    end
  end
end
