defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite(strings) do
    lines =
      Enum.chunk_every(strings, 2, 1, :discard)
      |> Enum.map(&line/1)
      |> Enum.join()

    lines <> line([hd(strings)])
  end

  defp line([word]), do: "And all for the want of a #{word}.\n"
  defp line([word1, word2]), do: "For want of a #{word1} the #{word2} was lost.\n"
end
