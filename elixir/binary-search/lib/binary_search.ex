defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key), do: _search(numbers, key, 0, tuple_size(numbers)-1)

  defp _search(_, _, low, high) when low > high, do: :not_found
  defp _search(numbers, key, low, high) do
    mid_idx = div(low + high, 2)
    test = elem(numbers, mid_idx)
    cond do
      key === test -> {:ok, mid_idx}
      key < test -> _search(numbers, key, low, mid_idx-1)
      key > test -> _search(numbers, key, mid_idx+1, high)
    end
  end
end
