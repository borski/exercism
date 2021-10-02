defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    lines = String.split(input, "\n")

    len =
      Enum.max_by(lines, &String.length/1)
      |> String.length()

    lines
    |> Enum.map(&pad(&1, len))
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map_join("\n", &(&1 |> Tuple.to_list() |> Enum.join() |> clean()))
  end

  defp pad(line, len) do
    line
    |> String.pad_trailing(len, "\x00")
  end

  defp clean(line) do
    line
    |> String.trim_trailing("\x00")
    |> String.replace("\x00", " ")
  end
end
