defmodule LogLevel do
  def to_label(level, legacy?) do
    case level do
      0 when not legacy? -> :trace
      1 -> :debug
      2 -> :info
      3 -> :warning
      4 -> :error
      5 when not legacy? -> :fatal
      _ -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    # Please implement the alert_recipient/2 function
  end
end
