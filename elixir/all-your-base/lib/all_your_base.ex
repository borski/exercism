defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}

  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}

  def convert(digits, input_base, output_base) do
    cond do
      Enum.any?(digits, &(&1 < 0 || &1 >= input_base)) -> {:error, "all digits must be >= 0 and < input base"}
      true -> {:ok, digits |> to_base_10(input_base) |> to_other_base(output_base)}
    end
  end

  defp to_base_10(digits, base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {digit, i} -> digit * Integer.pow(base, i) end)
    |> Enum.sum()
  end

  defp to_other_base(number, base), do: to_other_base(number, base, [])

  defp to_other_base(0, _, []), do: [0]
  defp to_other_base(0, _, result), do: result
  defp to_other_base(number, base, result) do 
    to_other_base(
      div(number, base), 
      base, 
      [rem(number, base) | result]
    )
  end
end
