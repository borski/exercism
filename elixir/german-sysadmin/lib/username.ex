defmodule Username do
  def sanitize(''), do: ''
  def sanitize(username) do
    [letter | rest] = username

    case letter do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      x when x in ?a..?z or x === ?_ -> [x]
      _ -> ''
    end ++ sanitize(rest)
  end
end
