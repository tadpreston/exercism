defmodule ProteinTranslation do
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> String.codepoints()
    |> Enum.chunk_every(3) 
    |> Enum.map(&Enum.join/1)
    |> Enum.reduce_while({:ok, []}, fn c, acc ->
      case of_codon(c) do
        {:ok, "STOP"} -> {:halt, acc}
        {:ok, protein} -> {:cont, {:ok, elem(acc,1) ++ [protein]}}
        {:error, _} -> {:halt, {:error, "invalid RNA"}}
      end
    end)
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case @codons[codon] do
      nil     -> {:error, "invalid codon"}
      protein -> {:ok, protein}
    end
  end
end
