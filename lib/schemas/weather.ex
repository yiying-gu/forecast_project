defmodule ForecastProject.Weather do
  use Ecto.Schema

  schema "weather" do
    field :temperature, :float
    field :updated_at, :string

  end
end
