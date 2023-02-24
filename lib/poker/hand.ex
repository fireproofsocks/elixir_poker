defmodule Poker.Hand do
  @moduledoc """
  Describes a Poker hand including scoring attributes and a `compare/2` function.
  """
  defstruct [
    :cards,
    :straight_flush?,
    :four_of_a_kind?,
    :full_house?,
    :flush?,
    :straight?,
    :three_of_a_kind?,
    :two_pair?,
    :pair?,
    :high_card_in_set,
    :high_card
  ]

  @doc """
  Creates and scores a hand of cards
  """
  def new(cards) when is_list(cards) do
    flush? = flush?(cards)
    straight? = straight?(cards)
    grouped = group(cards)

    %__MODULE__{
      cards: cards,
      straight_flush?: straight? and flush?,
      four_of_a_kind?: Map.has_key?(grouped, 4),
      full_house?: Map.has_key?(grouped, 3) and Map.has_key?(grouped, 2),
      flush?: flush?,
      straight?: straight?,
      three_of_a_kind?: Map.has_key?(grouped, 3),
      two_pair?: length(Map.get(grouped, 2, [])) == 2,
      pair?: Map.has_key?(grouped, 2),
      high_card_in_set: high_card_in_set(grouped),
      high_card: high_card(cards)
    }
  end

  @doc """
  Compares 2 `%Poker.Hand{}` structs. Used by `Enum.sort/2` to rank hands. This
  function contains all the "business logic" about how we score our poker games.

  Returns:

  - `:eq` when both hands are equal
  - `:gt` when hand1 outscores hand2
  - `:gl` when hand1 underscores hand2
  """
  def compare(%__MODULE__{straight_flush?: true}, %__MODULE__{straight_flush?: false}), do: :gt
  def compare(%__MODULE__{straight_flush?: false}, %__MODULE__{straight_flush?: true}), do: :lt
  def compare(%__MODULE__{four_of_a_kind?: true}, %__MODULE__{four_of_a_kind?: false}), do: :gt
  def compare(%__MODULE__{four_of_a_kind?: false}, %__MODULE__{four_of_a_kind?: true}), do: :lt
  def compare(%__MODULE__{full_house?: true}, %__MODULE__{full_house?: false}), do: :gt
  def compare(%__MODULE__{full_house?: false}, %__MODULE__{full_house?: true}), do: :lt
  def compare(%__MODULE__{flush?: true}, %__MODULE__{flush?: false}), do: :gt
  def compare(%__MODULE__{flush?: false}, %__MODULE__{flush?: true}), do: :lt
  def compare(%__MODULE__{straight?: true}, %__MODULE__{straight?: false}), do: :gt
  def compare(%__MODULE__{straight?: false}, %__MODULE__{straight?: true}), do: :lt
  def compare(%__MODULE__{three_of_a_kind?: true}, %__MODULE__{three_of_a_kind?: false}), do: :gt
  def compare(%__MODULE__{three_of_a_kind?: false}, %__MODULE__{three_of_a_kind?: true}), do: :lt
  def compare(%__MODULE__{two_pair?: true}, %__MODULE__{two_pair?: false}), do: :gt
  def compare(%__MODULE__{two_pair?: false}, %__MODULE__{two_pair?: true}), do: :lt
  def compare(%__MODULE__{pair?: true}, %__MODULE__{pair?: false}), do: :gt
  def compare(%__MODULE__{pair?: false}, %__MODULE__{pair?: true}), do: :lt

  def compare(%__MODULE__{high_card_in_set: c1}, %__MODULE__{high_card_in_set: c2})
      when not is_nil(c1) and not is_nil(c2),
      do: Poker.Card.compare(c1, c2)

  def compare(%__MODULE__{high_card: c1}, %__MODULE__{high_card: c2}),
    do: Poker.Card.compare(c1, c2)

  defp flush?([%{suit: suit} | _] = cards) do
    Enum.all?(cards, fn %{suit: xsuit} -> suit == xsuit end)
  end

  defp straight?(cards) do
    Enum.reduce_while(cards, true, fn
      %{rel_rank: curr}, prev when prev == true or curr == prev + 1 ->
        {:cont, curr}

      _curr, _prev ->
        {:halt, false}
    end)
  end

  defp high_card_in_set(grouped) do
    grouped |> Map.values() |> List.flatten() |> high_card()
  end

  defp high_card(cards) when is_list(cards) do
    cards
    |> Enum.sort({:desc, Poker.Card})
    |> List.first()
  end

  # group any pairs, triples, or four-of-a-kind together
  # e.g. %{2 => [pair1], 3 => [three_of_a_kind]}
  defp group(cards) do
    cards
    |> Enum.group_by(fn %{rel_rank: rel_rank} -> rel_rank end)
    |> Enum.reduce(%{}, fn {_, vals}, acc ->
      case length(vals) do
        1 ->
          acc

        x ->
          existing = Map.get(acc, x, [])
          Map.put(acc, x, [vals | existing])
      end
    end)
  end
end
