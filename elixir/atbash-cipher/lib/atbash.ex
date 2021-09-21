defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> (&Regex.scan(~r/[a-z0-9]/, &1)).()
    |> List.to_charlist()
    |> Enum.map(&encode_char/1)
    |> Enum.chunk_every(5)
    |> Enum.map_join(" ", &List.to_string(&1))
  end

  defp encode_char(c) when c in ?0..?9, do: c
  defp encode_char(c), do: ?z - (c - ?a)

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(" ", "")
    |> String.to_charlist()
    |> Enum.map(&decode_char/1)
    |> List.to_string()
  end

  defp decode_char(c) when c in ?0..?9, do: c
  defp decode_char(c), do: ?a + (?z - c)
end
