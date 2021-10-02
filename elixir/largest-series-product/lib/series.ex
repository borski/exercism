defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, size) when size < 0, do: raise(ArgumentError)
  def largest_product(_, 0), do: 1

  def largest_product(number_string, size) do
    if size > String.length(number_string), do: raise(ArgumentError)

    number_string
    |> String.to_integer()
    |> Integer.digits()
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&Enum.reduce(&1, fn x, acc -> x * acc end))
    |> Enum.max(&>=/2, fn -> 0 end)
  end
end
