defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(plaintext) do
    cleaned =
      plaintext
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9]/, "")
      |> String.graphemes()

    num_columns =
      cleaned
      |> length()
      |> :math.sqrt()
      |> Float.ceil()
      |> trunc()

    cleaned
    |> Enum.chunk_every(num_columns, num_columns, Stream.cycle([" "]))
    |> Enum.zip()
    |> Enum.map_join(" ", &Tuple.to_list(&1))
  end
end
