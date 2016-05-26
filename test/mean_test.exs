defmodule Homebody.MeanTest do
  use ExUnit.Case, async: true
  alias Homebody.Mean

  test "accumulates the mean of a set of values" do
    mean = [1,7,5,3,9,11,-1]
    |> Enum.reduce(Mean.new, fn(num, mean) -> Mean.add(mean, num) end)
    assert Mean.value(mean) == 5.0
  end
end
