defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @default_message "stack underflow occurred"
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "#{@default_message}, context: #{value}"}
      end
    end
  end

  def divide(numbers) when length(numbers) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([divisor, _]) when divisor == 0, do: raise(DivisionByZeroError)
  def divide([divisor, number]), do: number / divisor
end
