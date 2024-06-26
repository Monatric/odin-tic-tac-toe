# insert class description
class TicTacToe
  def initialize
    @is_game_finished = false
    @player1 = "Player 1"
    @player2 = "Player 2"
    @next_turn = @player_1
  end

  def start_game
    puts "The game has begun. It is Player 1's turn. Your letter is X."
    puts "Enter a number where you want to place the letter."
    puts "The current board             Guide"
    puts "   |   |                    1 | 2 | 3 "
    puts "---|---|---                ---|---|---"
    puts "   |   |                    4 | 5 | 6 "
    puts "---|---|---                ---|---|---"
    puts "   |   |                    7 | 8 | 9 "
  end
end
