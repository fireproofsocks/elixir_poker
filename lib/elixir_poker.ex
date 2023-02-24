defmodule ElixirPoker do
  @moduledoc """
  Evaluating Poker hands in Elixir as a code sample.

  This implementation stays true to the given test cases and module names by keeping
  them exactly as written. However some thought was given as to potential future
  expansion/improvement, for example:

  - Rename module to simply `Poker` to avoid redundancy.
  - More robust parsing, e.g. to handle lowercase letters or `10` instead of `T`.
  - `compare/2` should return a tuple because errors are possible!
  - Add support for more than 2 players. Because I implemented `Poker.Hand` as a
    sortable struct with a `compare/2` function, it would be simple for this code
    to rank the hands of multiple players and get a real game going!
  - support for errors flagging invalid input (e.g. "AS AS AS") could be implemented
    by refactoring the `lookup/1` function to leverage `Enum.map_reduce/3` to simulate
    drawing cards from a deck.
  - Support for `gettext` localization for any messaging.

  A more challenging (but interesting) augmentation would feature support for wild
  cards.

  """
  # calculate our deck of cards at compile time
  @vals Enum.to_list(2..9) ++ ["T", "J", "Q", "K", "A"]
  @suits ["C", "D", "H", "S"]
  @ranked_cards for v <- @vals, s <- @suits, do: {s, v}

  @deck @ranked_cards
        |> Enum.with_index(1)
        |> Enum.map(fn {{suit, value}, rank} ->
          Poker.Card.new(suit, value, rank)
        end)

  @dict @deck |> Enum.map(fn %{id: id} = card -> {id, card} end) |> Enum.into(%{})

  alias Poker.Hand

  @doc """
  Compares 2 strings representing poker hands and evaluates the winner.
  """
  def compare(player1, player2) do
    hand1 = player1 |> parse!() |> Hand.new()
    hand2 = player2 |> parse!() |> Hand.new()

    case Hand.compare(hand1, hand2) do
      :gt ->
        "Player 1 Wins"

      :lt ->
        "Player 2 Wins"

      :eq ->
        "Tie"
    end
  end

  # Parses human shorthand into a list of Card structs.
  # 1st char denotes the value: 2 thru Ace (T for 10).
  # 2nd char denotes the suit: S(pades), H(earts), D(iamonds), C(lubs)
  defp parse!(shorthand) when is_binary(shorthand) do
    shorthand
    |> String.split(" ")
    |> Enum.map(&lookup/1)
  end

  # Lookup a Card by its id, e.g. `8S`
  defp lookup(card_id), do: Map.fetch!(@dict, card_id)
end
