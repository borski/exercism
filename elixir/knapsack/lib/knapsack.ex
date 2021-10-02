defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer

  def maximum_value([], _), do: 0

  def maximum_value([first | rest], maximum_weight) when first.weight > maximum_weight do
    maximum_value(rest, maximum_weight)
  end

  def maximum_value([first | rest], maximum_weight) do
    Enum.max([
      first.value + maximum_value(rest, maximum_weight - first.weight),
      maximum_value(rest, maximum_weight)
    ])
  end
end
