defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)

    Enum.map(digits, &Integer.pow(&1, length(digits)))
    |> Enum.sum() === number
  end
end
