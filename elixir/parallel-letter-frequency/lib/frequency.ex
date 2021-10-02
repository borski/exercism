defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    Task.async_stream(texts, &count/1, max_concurrency: workers)
    |> Enum.reduce(
      %{},
      fn {:ok, map}, acc ->
        Map.merge(acc, map, fn _, v1, v2 -> v1 + v2 end)
      end
    )
  end

  defp count(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.filter(&Regex.match?(~r/\p{L}/, &1))
    |> Enum.reduce(%{}, fn letter, map -> Map.update(map, letter, 1, &(&1 + 1)) end)
  end
end
