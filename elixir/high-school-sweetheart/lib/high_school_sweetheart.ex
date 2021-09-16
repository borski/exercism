defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name
    |> String.trim
    |> String.first
  end

  def initial(name) do
    first = name
      |> first_letter
      |> String.upcase

    "#{first}."
  end

  def initials(full_name) do
    # Please implement the initials/1 function
    full_name
    |> String.split
    |> Enum.map(&(initial(&1)))
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    i1 = initials(full_name1)
    i2 = initials(full_name2)
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{i1}  +  #{i2}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
