defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino] | []) :: boolean

  def chain?([]), do: true
  def chain?([domino | dominoes]), do: next(domino, dominoes)

  defp next({x, y}, []), do: x == y
  defp next(_, []), do: false

  defp next({first, last}, bag) do
    Enum.any?(bag, fn
      next_domino = {^last, y} -> next({first, y}, List.delete(bag, next_domino))
      next_domino = {y, ^last} -> next({first, y}, List.delete(bag, next_domino))
      _ -> false
    end)
  end
end
