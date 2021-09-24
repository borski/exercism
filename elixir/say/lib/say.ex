defmodule Say do
  @hundred  100
  @thousand 1_000

  @million  @thousand * @thousand
  @billion  @million  * @thousand
  @trillion @billion  * @thousand

  @twodigitsorless %{            
    1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten",
    11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen",  
    19 => "nineteen", 20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}

  def in_english(number) when number not in 0..@trillion-1, do: {:error, "number is out of range"}
  def in_english(0), do: {:ok, "zero"}
  def in_english(number), do: {:ok, number_to_words(number)}

  defp number_to_words(number) when number <= 20, do: @twodigitsorless[number]
  defp number_to_words(number) when number < @hundred do
    case rem(number, 10) do
      0 -> @twodigitsorless[number]
      rem -> @twodigitsorless[number - rem] <> "-" <> @twodigitsorless[rem]
    end
  end

  defp number_to_words(number) when number < @thousand, do: bigboynumber(number, @hundred, "hundred")
  defp number_to_words(number) when number < @million, do: bigboynumber(number, @thousand, "thousand")
  defp number_to_words(number) when number < @billion, do: bigboynumber(number, @million, "million")
  defp number_to_words(number), do: bigboynumber(number, @billion, "billion")

  defp bigboynumber(number, base, suffix) do
    units = div(number, base)
    words = "#{number_to_words(units)} #{suffix}"
    case rem(number, base) do
      0 -> words
      rem -> "#{words} #{number_to_words(rem)}"
    end
  end
end
