defmodule Poker.Card do
  @moduledoc """
  Defines a playing card.
  """
  defstruct [:id, :suit, :face_value, :abs_rank, :rel_rank, :label]

  @doc """
  Hydrates a new Card struct
  """
  def new(suit, value, abs_rank) do
    %__MODULE__{
      id: "#{value}" <> suit,
      suit: suit,
      face_value: "#{value}",
      label: label(suit, value),
      abs_rank: abs_rank,
      rel_rank: rel_rank(value)
    }
  end

  defp label(s, "T"), do: "10" <> suit_icon(s)
  defp label(s, v), do: "#{v}" <> suit_icon(s)

  defp rel_rank("A"), do: 14
  defp rel_rank("K"), do: 13
  defp rel_rank("Q"), do: 12
  defp rel_rank("J"), do: 11
  defp rel_rank("T"), do: 10
  defp rel_rank(value), do: value

  # https://www.alt-codes.net/suit-cards.php
  defp suit_icon("H"), do: "♡"
  defp suit_icon("C"), do: "♣"
  defp suit_icon("D"), do: "♢"
  defp suit_icon("S"), do: "♠"

  @doc """
  Compares 2 `%Poker.Card{}` structs. Used by `Enum.sort/2` to rank cards.

  Returns:

  - `:eq` when both cards are equal
  - `:gt` when card1 is greater than card2
  - `:gl` when card1 is less than card2
  """
  def compare(%__MODULE__{abs_rank: rank1}, %__MODULE__{abs_rank: rank2}) when rank1 == rank2,
    do: :eq

  def compare(%__MODULE__{abs_rank: rank1}, %__MODULE__{abs_rank: rank2}) when rank1 > rank2,
    do: :gt

  def compare(%__MODULE__{abs_rank: rank1}, %__MODULE__{abs_rank: rank2}) when rank1 < rank2,
    do: :lt
end
