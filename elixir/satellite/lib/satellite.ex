defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}

  def build_tree(preorder, inorder) do
    cond do
      length(preorder) != length(inorder) ->
        {:error, "traversals must have the same length"}

      Enum.sort(preorder) != Enum.sort(inorder) ->
        {:error, "traversals must have the same elements"}

      Enum.uniq(preorder) != preorder or Enum.uniq(inorder) != inorder ->
        {:error, "traversals must contain unique items"}

      true ->
        {:ok, do_build(preorder, inorder)}
    end
  end

  defp do_build([], []), do: {}

  defp do_build([root | rest], inorder) do
    {left, [^root | right]} =
      inorder
      |> Enum.split_while(&(&1 != root))

    pre_right = rest -- left
    pre_left = rest -- pre_right

    {do_build(pre_left, left), root, do_build(pre_right, right)}
  end
end
