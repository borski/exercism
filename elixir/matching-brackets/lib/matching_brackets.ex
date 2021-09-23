defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    String.replace(str, ~r/[^\(\)\[\]\{\}]+/, "")
    |> do_check()
  end

  def do_check(""), do: true

  def do_check(str) do
    consumed = String.replace(str, ~r/\(\)|\[\]|\{\}/, "")

    if String.length(consumed) != String.length(str) do
      do_check(consumed)
    else
      false
    end
  end
end
