defmodule ForecastProject.GetTemperature do
  alias ForecastProject.Weather
  alias ForecastProject.Repo

  def run() do
    fetch_temp("Tokyo")
    |> save_db
  end

  def first_column do
    Enum.join ~w(DateTime Temperature), ","
  end

  def get_endpoint(location) do
    appid = "828acec70826ffd03794b32a36a7b228"
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{appid}"
  end

  def kelvin_to_celsius(kelvin) do
    (kelvin - 273.15) |> Float.round(1)
  end

  def temperature_of(location) do
    result = get_endpoint(location) |> HTTPoison.get |> parser_response
    case result do
      {:ok, temp} ->
        temp
      :error ->
        "#{location} not found"
    end
  end

  def fetch_temp(location) do
    now = DateTime.to_string(%{DateTime.utc_now() | microsecond: {0,0}})
    temp = temperature_of(location)
    [ now,
      temp
    ]
  end

  def save_db([_, temp]) do
    now = DateTime.utc_now()
    %Weather{
      temperature: temp,
      updated_at: now,
      inserted_at: now
    } |> Repo.insert
  end

  def save_csv(rows) do
    row = rows |> Enum.join(", ")
    filename = "temperature.csv"
    unless File.exists? filename do
      File.write! filename, first_column() <> "\n"
    end
    File.write! filename, row <> "\n", [:append]
  end

  defp parser_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temperature
  end

  defp parser_response(_), do: :error

  defp compute_temperature(json) do
    try do
      temp = json["main"]["temp"] |> kelvin_to_celsius
      {:ok, temp}
    rescue
      _ -> :error
    end
  end
end
