defmodule BasketballWebsite do
  def extract_from_path(data, []), do: data
  def extract_from_path(data, [h | t]), do: extract_from_path(data[h], t)
  def extract_from_path(data, path), do: extract_from_path(data, String.split(path, "."))

  def get_in_path(data, path), do: get_in(data, String.split(path, "."))
end
