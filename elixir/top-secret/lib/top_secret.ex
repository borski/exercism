defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast = {op, _, args}, acc)
      when op in [:def, :defp] do
    # require IEx
    # IEx.pry()
    {fn_name, args} = get_func_name_and_args(args)

    arity = length(args)

    {ast, [fn_name |> to_string |> String.slice(0, arity) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    {_, message} = string |> to_ast() |> Macro.prewalk([], &decode_secret_message_part/2)

    message
    |> Enum.reverse()
    |> Enum.join()
  end

  defp get_func_name_and_args(func) do
    case func do
      [{:when, _, args} | _] -> get_func_name_and_args(args)
      [{name, _, args} | _] when is_list(args) -> {name, args}
      [{name, _, _} | _] -> {name, []}
    end
  end
end
