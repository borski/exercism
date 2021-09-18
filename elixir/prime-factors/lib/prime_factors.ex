defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: factors_for(number, 2)

  defp factors_for(1, _), do: []
  defp factors_for(number, test) when rem(number, test) === 0, do: [test | factors_for(div(number, test), test)]
  defp factors_for(number, test), do: factors_for(number, test+1)
end
