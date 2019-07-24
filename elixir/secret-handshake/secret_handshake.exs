defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  use Bitwise

  @events [
    {0b1,    "wink"},
    {0b10,   "double blink"},
    {0b100,  "close your eyes"},
    {0b1000, "jump"}
  ]

  @reverse 0b10000

  @spec commands(code :: integer) :: list(String.t())
  def commands(cmd) do
    cmd
    |> get_commands()
    |> reverse_it(cmd)
  end

  defp get_commands(cmd) do
    for {code, oper} <- @events, band(cmd, code) == code, into: [], do: oper
  end

  defp reverse_it(handshake, cmd) when band(cmd, @reverse) == @reverse, do: Enum.reverse(handshake)
  defp reverse_it(handshake, _), do: handshake
end
