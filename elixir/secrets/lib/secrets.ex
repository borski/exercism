defmodule Secrets do
  use Bitwise, only_operators: true

  def secret_add(secret) do
    &(&1 + secret)
  end

  def secret_subtract(secret) do
    &(&1 - secret)
  end

  def secret_multiply(secret) do
    &(&1 * secret)
  end

  def secret_divide(secret) do
    &(div(&1,secret))
  end

  def secret_and(secret) do
    &(&1 &&& secret)
  end

  def secret_xor(secret) do
    &(Bitwise.bxor(&1, secret))
  end

  def secret_combine(secret_function1, secret_function2) do
    &(secret_function1.(&1) |> secret_function2.())
  end
end
