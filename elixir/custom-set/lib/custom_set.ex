defmodule CustomSet do
  defstruct map: %{}

  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable), do: Enum.reduce(enumerable, %__MODULE__{}, &add(&2, &1))

  @spec empty?(t) :: boolean
  def empty?(%__MODULE__{map: map}), do: Enum.empty?(map)

  @spec contains?(t, any) :: boolean
  def contains?(%__MODULE__{map: map}, element), do: Map.has_key?(map, element)

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    intersection(custom_set_1, custom_set_2)
    |> equal?(custom_set_1)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    intersection(custom_set_1, custom_set_2)
    |> empty?()
  end

  @spec equal?(t, t) :: boolean
  def equal?(%__MODULE__{map: map1}, %__MODULE__{map: map2}), do: map1 == map2

  @spec add(t, any) :: t
  def add(custom_set, element), do: put_in(custom_set.map[element], nil)

  @spec intersection(t, t) :: t
  def intersection(%__MODULE__{map: map1}, custom_set_2) do
    map1
    |> Map.keys()
    |> Enum.filter(&contains?(custom_set_2, &1))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(%__MODULE__{map: map1}, custom_set_2) do
    map1
    |> Map.keys()
    |> Enum.reject(&contains?(custom_set_2, &1))
    |> new()
  end

  @spec union(t, t) :: t
  def union(%__MODULE__{map: map1}, %__MODULE__{map: map2}) do
    new(Map.keys(map1) ++ Map.keys(map2))
  end
end
