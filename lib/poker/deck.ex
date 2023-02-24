defmodule Poker.Deck do
  @moduledoc """
  A deck of poker cards. This implements the "business logic" that determines
  the ranking by suit.

  Different games might rank suits differently; you could define a deck as a
  behaviour and have multiple implementations if different ranking is required.
  See https://apex.poker/card-suit-order/
  """
  @vals Enum.to_list(2..9) ++ ["T", "J", "Q", "K", "A"]
  @suits ["C", "D", "H", "S"]
  @ranked_cards for v <- @vals, s <- @suits, do: {s, v}

  @deck @ranked_cards
        |> Enum.with_index(1)
        |> Enum.map(fn {{suit, value}, rank} ->
          Poker.Card.new(suit, value, rank)
        end)

  @dict @deck |> Enum.map(fn %{id: id} = card -> {id, card} end) |> Enum.into(%{})

  @doc "Gets a brand new, unshuffled deck"
  def new, do: @deck

  @doc "Lookup a Card by its id, e.g. `8S`"
  def lookup(card_id), do: Map.fetch!(@dict, card_id)
end
