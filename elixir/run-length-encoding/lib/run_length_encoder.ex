defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.split("", trim: true)
    |> Enum.chunk_by(&(&1))
    |> Enum.map_join("", &encode_list/1)
  end

  @spec decode(String.t()) :: String.t()
  def decode(""), do: ""
  def decode(string) do
    case Integer.parse(string) do
      :error ->
       String.first(string) <> decode(String.slice(string, 1..-1))
      {n, <<first::binary-size(1), rest::binary>>} -> 
        String.duplicate(first, n) <> decode(rest)
    end
  end

  defp encode_list(chars) when length(chars) == 1, do: hd(chars)
  defp encode_list(chars), do: "#{length(chars)}#{hd(chars)}"
end
