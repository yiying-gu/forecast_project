defmodule ForecastProject.Repo.Migrations.AddUpdatedAt do
  use Ecto.Migration

  def change do
    alter table(:weather) do
      add :updated_at, :utc_datetime
    end
  end
end
