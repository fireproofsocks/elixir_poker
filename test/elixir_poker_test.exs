defmodule ElixirPokerTest do
  use ExUnit.Case
  doctest ElixirPoker

  @ace_high_flush "AH 9H 7H KH 2H"
  @nine_seven_high_flush "3H 9H 7H 4H 2H"
  @nine_six_high_flush "3D 9D 6D 4D 2D"
  @three_of_a_kind_7s_king_kicker "7S 7C 7D KH 4S"
  @three_of_a_kind_9s_jack_kicker "9S 9C 9D JH 4S"
  @pair_of_9s_jack_kicker "9D 9S JC 4C 2D"
  @pair_of_9s_eight_kicker "9H 9C 8C 4S 2H"
  @pair_of_king_ten_kicker "KH KS TD 5H 3S"
  @high_card_king_ten "KS TD 5D 8C 6C"
  @high_card_king_nine "KD 9D 5S 8H 6S"
  @high_card_ten_seven "TH 7D 3C 5D 2C"
  
  test "a Flush beats Three of a Kind" do
    assert ElixirPoker.compare(@ace_high_flush, @three_of_a_kind_7s_king_kicker) == "Player 1 Wins"
    assert ElixirPoker.compare(@three_of_a_kind_7s_king_kicker, @ace_high_flush) == "Player 2 Wins"
  end
  
  test "a Flush beats a Pair" do
    assert ElixirPoker.compare(@ace_high_flush, @pair_of_9s_jack_kicker) == "Player 1 Wins"
    assert ElixirPoker.compare(@pair_of_9s_jack_kicker, @ace_high_flush) == "Player 2 Wins"
  end
  
  test "a Flush beats High Card" do
    assert ElixirPoker.compare(@ace_high_flush, @high_card_king_ten) == "Player 1 Wins"
    assert ElixirPoker.compare(@high_card_king_ten, @ace_high_flush) == "Player 2 Wins"
  end

  test "Three of a Kind beats a Pair" do
    assert ElixirPoker.compare(@three_of_a_kind_7s_king_kicker, @pair_of_9s_jack_kicker) == "Player 1 Wins"
    assert ElixirPoker.compare(@pair_of_9s_jack_kicker, @three_of_a_kind_7s_king_kicker) == "Player 2 Wins"    
  end
  
  test "Three of a Kind beats High Card" do
    assert ElixirPoker.compare(@three_of_a_kind_7s_king_kicker, @high_card_king_ten) == "Player 1 Wins"
    assert ElixirPoker.compare(@high_card_king_ten, @three_of_a_kind_7s_king_kicker) == "Player 2 Wins" 
  end
  
  test "A Pair beats High Card" do
    assert ElixirPoker.compare(@pair_of_9s_jack_kicker, @high_card_king_ten) == "Player 1 Wins"
    assert ElixirPoker.compare(@high_card_king_ten, @pair_of_9s_jack_kicker) == "Player 2 Wins"     
  end
  
  #Bonus points
  
  test "The winner of two flushes is determined by the higher of unmatched cards" do
    assert ElixirPoker.compare(@ace_high_flush, @nine_six_high_flush) == "Player 1 Wins"
    assert ElixirPoker.compare(@nine_seven_high_flush, @nine_six_high_flush) == "Player 1 Wins"
  end
  
  test "The winner of two Three of a Kinds is determined by the rank of the sets" do
    assert ElixirPoker.compare(@three_of_a_kind_9s_jack_kicker, @three_of_a_kind_7s_king_kicker) == "Player 1 Wins"
  end
  
  test "The winner of two Pairs is determined by the rank of the sets" do
    assert ElixirPoker.compare(@pair_of_king_ten_kicker, @pair_of_9s_jack_kicker) == "Player 1 Wins"
  end
  
  test "The winner if both hands have pairs of the same rank is determined by the ranks of the highest non-pair cards in each hand" do
    assert ElixirPoker.compare(@pair_of_9s_jack_kicker, @pair_of_9s_eight_kicker) == "Player 1 Wins"
  end
  
  test "The winner if both hands are high card is determined by the rank highest cards not in both hands" do
    assert ElixirPoker.compare(@high_card_king_ten, @high_card_ten_seven) == "Player 1 Wins"
    assert ElixirPoker.compare(@high_card_king_ten, @high_card_king_nine) == "Player 1 Wins"
  end
end
