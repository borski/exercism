defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :battery_percentage,
    :distance_driven_in_meters,
    :nickname
  ]

  def new(), do: %__MODULE__{battery_percentage: 100, distance_driven_in_meters: 0, nickname: "none"}

  def new(nickname), do: %{new() | nickname: nickname}

  def display_distance(%__MODULE__{distance_driven_in_meters: d}), do: "#{d} meters"

  def display_battery(%__MODULE__{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%__MODULE__{battery_percentage: p}), do: "Battery at #{p}%"

  def drive(rc = %__MODULE__{battery_percentage: 0}), do: rc
  def drive(rc = %__MODULE__{battery_percentage: p, distance_driven_in_meters: d}), do: %{rc | battery_percentage: p - 1, distance_driven_in_meters: d + 20} 
end
