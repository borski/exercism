defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()

  def convert(number) do
    factors = %{
      3 => "Pling",
      5 => "Plang",
      7 => "Plong"
    }

    ret =
      Enum.filter(factors, fn {factor, _} -> divisible_by?(number, factor) end)
      |> Enum.reduce("", fn {_, sound}, acc -> acc <> sound end)

    if ret !== "", do: ret, else: Integer.to_string(number)
  end

  defp divisible_by?(number, factor), do: rem(number, factor) === 0
end
