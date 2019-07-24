defmodule PigLatin do
  @vowels ~w(a e i o u)

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map_join(" ", &(translate_word(&1)))
  end

  defp translate_word(word) do
    word
    |> String.codepoints()
    |> do_translate([])
    |> List.to_string()
  end

  defp do_translate([char | _] = phrase, acc) when char in @vowels, do: phrase ++ acc ++ ["ay"]
  defp do_translate(["q" | tail], acc) do
    [chr | t] = tail
    if chr == "u", do: do_translate(t, acc ++ ["qu"]), else: do_translate(tail, acc ++ ["q"])
  end
  defp do_translate([char | tail] = phrase, acc) when char in ~w(x y) do
    [chr | _] = tail
    if chr not in @vowels, do: phrase ++ ["ay"], else: do_translate(tail, acc ++ [char])
  end
  defp do_translate([char | tail], acc) when char not in @vowels, do: do_translate(tail, acc ++ [char])
end
