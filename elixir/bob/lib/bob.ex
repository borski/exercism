defmodule Bob do
  defp yelling?(input), do: String.upcase(input) === input and String.downcase(input) !== input

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    last_char = input |> String.trim |> String.last

    cond do
      yelling?(input) and last_char === "?" -> "Calm down, I know what I'm doing!"
      yelling?(input) -> "Whoa, chill out!"
      last_char === nil -> "Fine. Be that way!"
      last_char === "?" -> "Sure."
      true -> "Whatever."
    end
  end
end
