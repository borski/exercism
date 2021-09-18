defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """

  use Bitwise, operators_only: true

  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    allergies = %{
      1 => "eggs",
      2 => "peanuts",
      4 => "shellfish",
      8 => "strawberries",
      16 => "tomatoes",
      32 => "chocolate",
      64 => "pollen",
      128 => "cats"
    }

    Enum.filter(allergies, fn {k, _} -> (flags &&& k) === k end)
    |> Enum.into(%{})
    |> Map.values()
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item), do: item in list(flags)
end
