defmodule ForecastProjectTest do
  use ExUnit.Case
  doctest ForecastProject

  test "greets the world" do
    assert ForecastProject.hello() == :world
  end
end
