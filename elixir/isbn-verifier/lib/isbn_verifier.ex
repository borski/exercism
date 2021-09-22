defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn = String.replace(isbn, "-", "")

    if is_valid?(isbn) do
      sum = isbn
            |> String.split("", trim: true)
            |> Enum.map(&string_to_int/1)
            |> Enum.zip_reduce(10..1, 0, &(&1 * &2 + &3))

      rem(sum, 11) == 0
    else
      false
    end
  end

  defp is_valid?(isbn), do: String.length(isbn) <= 10 and isbn =~ ~r/[0-9]{9}[0-9|X]{1}/

  defp string_to_int("X"), do: 10
  defp string_to_int(s), do: String.to_integer(s)
end
