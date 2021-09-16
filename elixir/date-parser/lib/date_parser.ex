defmodule DateParser do
  def day() do
    "\\d{1,2}"
  end

  def month() do
    "\\d{1,2}"
  end

  def year() do
    "\\d{4}"
  end

  def day_names() do
    "\\b(Mon|Tues|Wednes|Thurs|Fri|Satur|Sun)(day)\\b"
  end

  def month_names() do
    "\\b(January|February|March|April|May|June|July|August|September|October|November|December)\\b"
  end

  def capture_day() do
    "(?<day>#{day()})"
  end

  def capture_month() do
    "(?<month>#{month()})"
  end

  def capture_year() do
    "(?<year>#{year()})"
  end

  def capture_day_name() do
    "(?<day_name>#{day_names()})"
  end

  def capture_month_name() do
    "(?<month_name>#{month_names()})"
  end

  def capture_numeric_date() do
    "#{capture_day()}\/#{capture_month()}\/#{capture_year()}"
  end

  def capture_month_name_date() do
    "#{capture_month_name()} #{capture_day()}, #{capture_year()}"
  end

  def capture_day_month_name_date() do
    "#{capture_day_name()}, #{capture_month_name_date()}"
  end

  def match_numeric_date() do
    "^#{capture_numeric_date()}$"
    |> Regex.compile
    |> elem(1)
  end

  def match_month_name_date() do
    "^#{capture_month_name_date()}$"
    |> Regex.compile
    |> elem(1)
  end

  def match_day_month_name_date() do
    "^#{capture_day_month_name_date()}$"
    |> Regex.compile
    |> elem(1)
  end
end
