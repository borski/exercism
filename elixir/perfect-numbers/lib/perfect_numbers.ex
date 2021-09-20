defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(1), do: {:ok, :deficient}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) do
    asum = aliquot_sum(number)
    cond do
      asum == number -> {:ok, :perfect}
      asum > number -> {:ok, :abundant}
      asum < number -> {:ok, :deficient}
    end
  end

  defp aliquot_sum(number) do
    1..number-1
    |> Enum.filter(&factor?(&1, number))
    |> Enum.sum()
  end

  defp factor?(factor, number), do: rem(number, factor) == 0
end
