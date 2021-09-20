defmodule Newsletter do
  def read_emails(path), do: File.read!(path) |> String.split("\n", trim: true)

  def open_log(path), do: File.open!(path, [:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log = open_log(log_path)

    Enum.each(emails, fn email ->
      if send_fun.(email) === :ok do
        log_sent_email(log, email)
      end
    end)

    close_log(log)
  end
end
