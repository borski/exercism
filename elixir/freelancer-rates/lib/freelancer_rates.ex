defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount * (discount / 100))
  end

  def monthly_rate(hourly_rate, discount) do
    base_rate = 22 * daily_rate(hourly_rate)
    discounted_rate = apply_discount(base_rate, discount)

    ceil(discounted_rate)
  end

  def days_in_budget(budget, hourly_rate, discount) do
    number_of_days = budget / apply_discount(hourly_rate, discount) / 8
    Float.floor(number_of_days, 1)
  end
end
