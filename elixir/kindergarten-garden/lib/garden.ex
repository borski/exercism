defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @plants %{
      ?G => :grass,
      ?C => :clover,
      ?R => :radishes,
      ?V => :violets,
    }

  @students [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    student_names = Enum.sort(student_names)
    garden = Map.new(student_names, &({&1, {}}))

    info_string
    |> String.split()
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.chunk_every(&1, 2))
    |> Enum.flat_map(&Enum.zip(student_names, &1))
    |> Enum.group_by(fn {k, _} -> k end, fn {_, v} -> v end)
    |> Enum.map(fn {k, v} -> {k, List.flatten(v)} end)
    |> Enum.map(fn {k, v} -> {k, convert_to_plants(v)} end)
    |> Enum.into(garden)
  end

  defp convert_to_plants(list), do: Enum.map(list, &(@plants[&1])) |> List.to_tuple()
end
