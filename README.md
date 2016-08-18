# ElixirPoker

**TODO: Add description**

POKER INTERVIEW QUESTION



Program description:

Build a program which can determine the winner of a poker game, looking at players hands only. A hand has 5 cards.

Input   =>  takes two string of characters representing the cards for each player (e.g. "2C 3H 4S 8C KH" and "QH QD 5S 7C 8D")
Output => returns the winner (optional: returns the reason for winning) 



Game description:

- A poker deck contains 52 cards.
- Each of the two players get 5.
- Each card has a suit which is one of CLUBS, DIAMONDS, HEARTS, or SPADES (denoted C, D, H, and S in the input data). 
- Each card also has a value which is one of 2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace (denoted 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A). 
- Suits are not ranked (they are equal in term of scoring)
- Values are ranked as presented above (2 lowest and Ace highest)

Normal poker combinations (by rank):
Straight flush:     9C 8C 7C 6C 5C       (5 consecutive & 5x same suit)
Four of a kind:    8D 8C 8S 8H 5C       (4x value)
Full House:         AC AD AH 8S 8C      (3x value + 2x value)
Flush:                 AS 9S 7S 6S 3S       (5x suit)
Straight:              9H 8D 7S 6C 5H       (5 consecutive)
Three of a Kind:  AC AD AH 9H 3S      (3x)
Two Pairs:          JC JD 9H 9S 7S        (2x value + 2x value)
Pair:                   JC JD 10H 9S 7S       (2x value) 
High Card:          AC 9S 7C 8S 3D        


Poker combinations for this interview (by rank):
Flush:                 AS 9S 7S 6S 3S       (5x suit)
Three of a Kind:  AC AD AH 9H 3S      (3x)
Pair:                   JC JD 10H 9S 7S       (2x value) 
High Card:          AC 9S 7C 8S 3D


Examples:

Flush:

Input: Black: 2H 7H 3H 5H JH White: 2C 3H 4S 8C KH
Output: Black wins - flush: J

Input: Black: 2H 7H 3H 5H JH White: 2C 3C 4C 8C KC
Output: White wins - flush: K



Three of a Kind

Input: Black: 2H 2D 2S 5C 9D White: 2C 3H 4S 8C KH
Output: Black wins - three of a kind: 2

Input: Black: 2H 2D 2S 5C 9D White: 2C 3H 4S 8C 8H
Output: Black wins - three of a kind: 2

Input: Black: 2H 2D 2S 5C 9D White: 2C 3H 8S 8C 8H
Output: White wins - three of a kind: 8



Pair

Input: Black: 2H 3D 5S KC KD White: 2C 3H 4S 8C KH
Output: Black wins - pair: King

Input: Black: QH QD 5S 7C 8D White: 2C 3H 4S KC KH
Output: White wins - pair: King

Input: Black: KS KD 5S 7C 8D White: 2C 3H 4S KC KH
Output: Black wins - High: 8



High Cards

Input: Black: 2H 3D 5S 9C KD White: 2C 3H 4S 8C AH
Output: White wins - high card: Ace 

Input: Black: 2H 3D 5S 9C AD White: 2C 3H 4S 8C AH
Output: Black wins - high card: 9 

Input: Black: 2H 3D 5S 9C AD White: 9H 3H 4S 8C AH
Output: White wins - high card: 8

Input: Black: 2H 3D 5S 9C KD White: 2D 3H 5C 9S KH
Output: Tie
