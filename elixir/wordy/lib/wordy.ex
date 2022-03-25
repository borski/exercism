defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    Regex.run(~r/What is (.*)\?/, question, capture: :all_but_first)
    |> hd()
    |> String.split()
    |> Stream.map(&convert/1)
    |> Enum.reject(&is_nil/1)
    |> compute()
  end

  defp convert("plus"), do: &+/2
  defp convert("minus"), do: &-/2
  defp convert("multiplied"), do: &*/2
  defp convert("divided"), do: &//2
  defp convert("by"), do: nil
  defp convert(num), do: String.to_integer(num)

  defp compute([n]), do: n
  defp compute([a, op, b | rest]), do: compute([op.(a, b) | rest])
end
