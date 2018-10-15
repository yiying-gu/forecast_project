defmodule ForecastProject.Weather do
  use Ecto.Schema
  @timestamps_opts [type: :utc_datetime]

  schema "weather" do
    field :temperature, :float
    field :updated_at, :utc_datetime
    field :inserted_at, :utc_datetime
  end
end
