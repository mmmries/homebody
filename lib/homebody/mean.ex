defmodule Homebody.Mean do
  def new, do: {0.0, 0}

  def add({avg, values}, new_value) do
    {(avg * values + new_value) / (values + 1), values + 1}
  end

  def value({avg, _}), do: avg
end
