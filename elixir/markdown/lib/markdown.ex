defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(&process_line/1)
    |> format_tags()
  end

  defp process_line("#" <> line), do: process_header(line, 1)
  defp process_line("* " <> line), do: "<li>#{line}</li>"
  defp process_line(line), do: "<p>#{line}</p>"

  defp process_header(" " <> line, 7), do: "<p>####### #{line}</p>"
  defp process_header(" " <> line, level), do: "<h#{level}>#{line}</h#{level}>"
  defp process_header("#" <> line, level), do: process_header(line, level + 1)

  defp format_tags(lines) do
    lines
    |> String.replace(~r/__([^_]+)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_([^_]+)_/, "<em>\\1</em>")
    |> String.replace(~r/<li>.*<\/li>/, "<ul>\\0</ul>")
  end
end
