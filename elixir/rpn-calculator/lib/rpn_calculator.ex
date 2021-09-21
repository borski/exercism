defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      operation.(stack)
    rescue
      RuntimeError -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      operation.(stack)
    rescue
      e in RuntimeError -> {:error, e.message}
    end
  end
end
