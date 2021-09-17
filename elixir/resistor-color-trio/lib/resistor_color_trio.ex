defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {integer, :ohms | :kiloohms}
  def label(colors) do
    color_map = %{
      black: 0,
      brown: 1,
      red: 2,
      orange: 3,
      yellow: 4,
      green: 5,
      blue: 6,
      violet: 7,
      grey: 8,
      white: 9
    }

    value = colors
            |> Enum.map(&(color_map[&1]))
            |> Enum.take(2)

    multiplier = colors
                 |> Enum.map(&(color_map[&1]))
                 |> List.last
                 |> (&List.duplicate(0,&1)).()

    total_value = Integer.undigits(value ++ multiplier)

    if total_value > 1000 do
      {total_value / 1000, :kiloohms}
    else
      {total_value, :ohms}
    end
  end
end
