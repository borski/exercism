defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  defstruct [:data, :left, :right]

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data), do: %__MODULE__{data: data}

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data), do: new(data)
  def insert(tree, data) do
    if data <= tree.data do
      %__MODULE__{tree | left: insert(tree.left, data)}
    else
      %__MODULE__{tree | right: insert(tree.right, data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []
  def in_order(tree) do
    [in_order(tree.left) | [tree.data | in_order(tree.right)]]
    |> List.flatten()
  end
end
