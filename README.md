# ElixirPoker

This repo describes an Elixir coding challenge where the interviewee is tasked with implementing part of a Poker game.

## Program Requirements

Build a function which can determine the winner of a hand of poker between two players (designated as Player 1 and Player 2). A hand has 5 cards.

**Input**: accepts two strings representing a hand of cards, e.g. `2C 3H 4S 8C KH` and `QH QD 5S 7C 8D`

**Output**: returns the winner (Player 1 or Player 2), and optionally returns the reason for winning.

## Game description

- A poker deck contains 52 cards.
- Each of the two players gets a hand of 5 cards.
- Each card has a suit which is one of CLUBS, DIAMONDS, HEARTS, or SPADES (denoted C, D, H, and S in the input data).
- Each card has a value which is one of 2, 3, 4, 5, 6, 7, 8, 9, 10, jack, queen, king, ace (denoted 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, A).
- Suits are not ranked (they are equal in term of scoring)
- Values are ranked as presented above (2 lowest and Ace highest)

Normal poker combinations (by rank):

| Hand                 | Example             | Description                    |
|----------------------|---------------------|--------------------------------|
| Straight flush       | `9C 8C 7C 6C 5C`    | 5 consecutive of the same suit |
| Four of a kind       | `8D 8C 8S 8H 5C`    | 4x value |
| Full House           | `AC AD AH 8S 8C`    | 3x value + 2x value |
| Flush                | `AS 9S 7S 6S 3S`    | 5x same suit |
| Straight             | `9H 8D 7S 6C 5H`    | 5 consecutive |
| Three of a Kind      | `AC AD AH 9H 3S`    | 3x |
| Two Pairs            | `JC JD 9H 9S 7S`    | 2x value + 2x value |
| Pair                 | `JC JD 10H 9S 7S`   | 2x value |
| High Card            | `AC 9S 7C 8S 3D`    |           |

Poker combinations for this interview (by rank):

| Hand                 | Example             | Description   |
|----------------------|---------------------|---------------|
| Flush                | `AS 9S 7S 6S 3S`    | 5x same suit  |
| Three of a Kind      | `AC AD AH 9H 3S`    | 3x            |
| Pair                 | `JC JD 10H 9S 7S`   | 2x value      |
| High Card            | `AC 9S 7C 8S 3D`    |               |

## Examples

### Flush

- Input: Player 1: `2H 7H 3H 5H JH`; Player 2: `2C 3H 4S 8C KH`
- Output: Player 1 wins - flush: J

- Input: Player 1: `2H 7H 3H 5H JH`; Player 2: `2C 3C 4C 8C KC`
- Output: Player 2 wins - flush: K

### Three of a Kind

- Input: Player 1: `2H 2D 2S 5C 9D`; Player 2: `2C 3H 4S 8C KH`
- Output: Player 1 wins - three of a kind: 2

- Input: Player 1: `2H 2D 2S 5C 9D`; Player 2: `2C 3H 4S 8C 8H`
- Output: Player 1 wins - three of a kind: 2

- Input: Player 1: `2H 2D 2S 5C 9D`; Player 2: `2C 3H 8S 8C 8H`
- Output: Player 2 wins - three of a kind: 8

### Pair

- Input: Player 1: `2H 3D 5S KC KD`; Player 2: `2C 3H 4S 8C KH`
- Output: Player 1 wins - pair: King

- Input: Player 1: `QH QD 5S 7C 8D`; Player 2: `2C 3H 4S KC KH`
- Output: Player 2 wins - pair: King

- Input: Player 1: `KS KD 5S 7C 8D`; Player 2: `2C 3H 4S KC KH`
- Output: Player 1 wins - High: 8

### High Cards

- Input: Player 1: `2H 3D 5S 9C KD`; Player 2: `2C 3H 4S 8C AH`
- Output: Player 2 wins - high card: Ace

- Input: Player 1: `2H 3D 5S 9C AD`; Player 2: `2C 3H 4S 8C AH`
- Output: Player 1 wins - high card: 9

- Input: Player 1: `2H 3D 5S 9C AD`; Player 2: `9H 3H 4S 8C AH`
- Output: Player 2 wins - high card: 8

- Input: Player 1: `2H 3D 5S 9C KD`; Player 2: 2D `3H 5C 9S KH`
- Output: Tie
