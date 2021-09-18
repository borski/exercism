defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1.price)

  def with_missing_price(inventory), do: Enum.filter(inventory, &is_nil(&1.price))

  def increase_quantity(item, count) do
    Map.replace(
      item,
      :quantity_by_size,
      item.quantity_by_size |> Enum.map(fn {size, n} -> {size, n + count} end) |> Enum.into(%{})
    )
  end

  def total_quantity(item), do: Enum.reduce(item.quantity_by_size, 0, &(elem(&1, 1) + &2))
  # Another option: Enum.reduce(item.quantity_by_size, 0, fn {_, count}, acc -> count + acc end)
end
