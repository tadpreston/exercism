defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    for <<char <- text>>, into: "", do: <<rotate_char(char, shift)>>
  end

  defp rotate_char(char, shift) when char in ?a..?z, do: do_shift(char, ?a, shift)
  defp rotate_char(char, shift) when char in ?A..?Z, do: do_shift(char, ?A, shift)
  defp rotate_char(char, _), do: char

  defp do_shift(char, base, shift), do: base + Integer.mod((char - base + shift), 26)
end
