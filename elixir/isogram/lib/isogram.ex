defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    # letters = 
      # sentence
      # |> String.replace([" ", "-"], "")
      # |> String.downcase
      # |> String.to_charlist

    # It's a regex exercise, so I suppose I should use a regex.
    letters = Regex.scan(~r/\w/, String.downcase(sentence))
    Enum.uniq(letters) == letters
  end
end
