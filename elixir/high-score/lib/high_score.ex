defmodule HighScore do
  def new(), do: %{}

  def add_player(scores, name, score \\ 0), do: Map.put(scores, name, score)

  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name), do: add_player(scores, name)

  def update_score(scores, name, score), do: add_player(scores, name, Map.get(scores, name, 0) + score)

  def get_players(scores), do: Map.keys(scores)
end
