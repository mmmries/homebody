defmodule HomebodyTest do
  use ExUnit.Case
  doctest Homebody

  test "the truth" do
    assert Homebody.service_name == "homebody._tcp"
  end
end
