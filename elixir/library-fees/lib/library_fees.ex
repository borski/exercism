defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime), do: Time.compare(datetime, ~T[12:00:00]) === :lt

  defp days_to_seconds(days), do: days * 24 * 60 * 60

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      checkout_datetime |> NaiveDateTime.add(days_to_seconds(28)) |> NaiveDateTime.to_date
    else  
      checkout_datetime |> NaiveDateTime.add(days_to_seconds(29)) |> NaiveDateTime.to_date
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime), do: Date.day_of_week(datetime) === 1

  def calculate_late_fee(checkout, return, rate) do
    checkout = datetime_from_string(checkout)
    return = datetime_from_string(return)

    fees = rate * days_late(return_date(checkout), return)

    if monday?(return), do: div(fees, 2), else: fees
  end
end
