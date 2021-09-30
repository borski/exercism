defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []

  def primes_to(limit) do
    2..limit
    |> Enum.to_list()
    |> sieve([])
  end

  defp sieve([], primes), do: Enum.reverse(primes)

  defp sieve([prime | rest], primes) do
    rest
    |> Enum.reject(&(rem(&1, prime) == 0))
    |> sieve([prime | primes])
  end
end
