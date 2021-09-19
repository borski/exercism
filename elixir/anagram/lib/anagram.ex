defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base = String.downcase(base)
    base_letters = split_and_sort(base)

    Enum.filter(
      candidates,
      &(split_and_sort(&1) === base_letters and String.downcase(&1) != base)
    )
  end

  defp split_and_sort(word) do
    word
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.sort()
  end
end
