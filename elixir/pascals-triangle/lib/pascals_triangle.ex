defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Stream.iterate([1], &[1 | make_row(&1)])
    |> Enum.take(num)
  end

  defp make_row(row) do
    Enum.chunk_every(row, 2, 1)
    |> Enum.map(&Enum.sum/1)
  end
end
