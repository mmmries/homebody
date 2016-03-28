defmodule Homebody.ReporterTest do
  use ExUnit.Case, async: true

  test "convert 0C to Faranheit" do
    assert_in_delta Homebody.Reporter.celsius_to_faranheit(0.0), 32.0, 0.01
  end

  test "convert 100C to Faranheit" do
    assert_in_delta Homebody.Reporter.celsius_to_faranheit(100.0), 212.0, 0.01
  end

  test "convert 25C to Faranheit" do
    assert_in_delta Homebody.Reporter.celsius_to_faranheit(25.0), 77.0, 0.01
  end
end
