defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> String.replace([" " | ~w/( ) . - +/], "")
    |> handle_number()
  end

  defp handle_number("0" <> <<_::binary-9>>), do: {:error, "area code cannot start with zero"}
  defp handle_number("10" <> <<_::binary-9>>), do: {:error, "area code cannot start with zero"}

  defp handle_number(<<_::binary-3>> <> "0" <> <<_::binary-6>>), do: {:error, "exchange code cannot start with zero"}
  defp handle_number("1" <> <<_::binary-3>> <> "0" <> <<_::binary-6>>), do: {:error, "exchange code cannot start with zero"}

  defp handle_number(<<_::binary-3>> <> "1" <> <<_::binary-6>>), do: {:error, "exchange code cannot start with one"}
  defp handle_number("1" <> <<_::binary-3>> <> "1" <> <<_::binary-6>>), do: {:error, "exchange code cannot start with one"}

  defp handle_number("1" <> <<number::binary-10>>), do: handle_number(number)

  defp handle_number(number) do 
    len = String.length(number)
    cond do
      len > 11 or len < 10 -> 
        {:error, "incorrect number of digits"}

      len == 11 and String.at(number, 0) != "1" -> 
        {:error, "11 digits must start with 1"}

      not Regex.match?(~r/\A\d*\z/, number) -> 
        {:error, "must contain digits only"}

      String.at(number, 0) == "1" -> 
        {:error, "area code cannot start with one"}
        
      true -> 
        {:ok, number}
    end 
  end
end
