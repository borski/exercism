defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec length(list) :: non_neg_integer
  def length([]), do: 0
  def length([_ | t]), do: 1 + ListOps.length(t)
 
  @spec reverse(list) :: list
  def reverse(list), do: ListOps.reverse(list, [])
  def reverse([], reversed), do: reversed
  def reverse([h | t], reversed), do: ListOps.reverse(t, [h | reversed])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h | t], f), do: [f.(h) | ListOps.map(t, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([h | t], f) do
    if f.(h) do
      [h | ListOps.filter(t, f)]
    else
      ListOps.filter(t, f)
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _), do: acc
  def foldl([h | t], acc, f), do: ListOps.foldl(t, f.(h, acc), f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr([], acc, _), do: acc
  def foldr([h | t], acc, f), do: f.(h, ListOps.foldr(t, acc, f))

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([h | t], b), do: [h | ListOps.append(t, b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h | t]), do: ListOps.append(h, concat(t))
end
