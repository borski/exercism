defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()

  def translate(phrase) do
    String.split(phrase) |> Enum.map(fn word -> translate_word(word) end) |> Enum.join(" ")
  end

  defp translate_word(word) do
    c = consonant_cluster(word)

    cond do
      starts_with_vowel?(word) -> word <> "ay"
      c -> String.replace_prefix(word, c, "") <> c <> "ay"
      true -> word
    end
  end

  defp starts_with_vowel?(phrase),
    do: String.starts_with?(phrase, ["a", "e", "i", "o", "u", "xr", "yt", "xb", "yd"])

  defp is_vowel?(c), do: Enum.member?([?a, ?e, ?i, ?o, ?u], c)

  defp consonant_cluster(phrase) do
    cond do
      String.starts_with?(phrase, "squ") ->
        "squ"

      String.starts_with?(phrase, "qu") ->
        "qu"

      String.starts_with?(phrase, "rhy") ->
        "rh"

      String.starts_with?(phrase, "my") ->
        "m"

      true ->
        String.to_charlist(phrase) |> Enum.take_while(fn c -> not is_vowel?(c) end) |> to_string
    end
  end
end
