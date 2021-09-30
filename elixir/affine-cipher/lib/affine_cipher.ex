defmodule AffineCipher do
  @typedoc """
  A type for the encryption key
  """
  @type key() :: %{a: integer, b: integer}

  @doc """
  Encode an encrypted message using a key
  """
  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: b}, message) do
    with {:ok, _} <- mmi(a, 26) do
      {
        :ok,
        message
        |> clean()
        |> Stream.map(fn c ->
          if c in ?a..?z do
            rem(a * (c - ?a) + b, 26) + ?a
          else
            c
          end
        end)
        |> Stream.chunk_every(5)
        |> Enum.map_join(" ", &to_string/1)
      }
    else
      nil -> {:error, "a and m must be coprime."}
    end
  end

  @doc """
  Decode an encrypted message using a key
  """
  @spec decode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: b}, encrypted) do
    with {:ok, mmi} <- mmi(a, 26) do
      {
        :ok,
        encrypted
        |> clean()
        |> Enum.map(fn c ->
          if c in ?a..?z do
            Integer.mod(mmi * (c - ?a - b), 26) + ?a
          else
            c
          end
        end)
        |> to_string()
      }
    else
      nil -> {:error, "a and m must be coprime."}
    end
  end

  defp clean(str) do
    str
    |> String.downcase()
    |> String.replace(~r/\W/, "")
    |> to_charlist()
  end

  defp mmi(a, m) do
    case Enum.find(1..m, nil, &(rem(a * &1, m) == 1)) do
      nil -> nil
      x -> {:ok, x}
    end
  end
end
