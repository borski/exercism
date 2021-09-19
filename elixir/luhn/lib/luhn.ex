defmodule Luhn do
  require Integer

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number = String.replace(number, " ", "")

    cond do
      String.length(number) <= 1 -> false
      not (number =~ ~r/^\d*$/) -> false
      true -> check(number)
    end
  end

  defp check(number) do
    number
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.map(&String.to_integer(&1))
    |> Enum.with_index()
    |> Enum.map(fn {num, i} ->
      cond do
        Integer.is_even(i) -> num
        num * 2 < 9 -> num * 2
        true -> num * 2 - 9
      end
    end)
    |> Enum.sum()
    |> rem(10) === 0
  end
end
