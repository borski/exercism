defmodule LogParser do
  def valid_line?(line), do: line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/

  def split_line(line), do: Regex.split(~r/<[~*=-]*>/, line)

  def remove_artifacts(line), do: Regex.replace(~r/end-of-line(\d+)/i, line, "")

  defp prefix_username(%{"username" => username}, line), do: "[USER] #{username} #{line}"
  defp prefix_username(nil, line), do: line

  def tag_with_user_name(line) do
    captures = Regex.named_captures(~r/User\s+(?<username>\S+)/u, line)

    prefix_username(captures, line)
  end
end
