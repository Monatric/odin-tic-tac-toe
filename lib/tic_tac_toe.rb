# insert class description
class TicTacToe
  def initialize
    @is_game_finished = false
    @player1 = "Player 1"
    @player2 = "Player 2"
    @next_turn = @player_1
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def start_game
    puts "The game has begun. It is Player 1's turn. Your letter is X."
    puts "Enter a number where you want to place the letter."
    state_of_the_board
    take_coord
  end

  

  private

  attr_accessor :board

  def take_coord
    coord = gets.chomp.to_i
    board[coord - 1] = "X"
    state_of_the_board#p board
  end

  def state_of_the_board
    puts "The current board             Guide"
    puts " #{board[0]} | #{board[1]} | #{board[2]}                  1 | 2 | 3 "
    puts "---|---|---                ---|---|---"
    puts " #{board[3]} | #{board[4]} | #{board[5]}                  4 | 5 | 6 "
    puts "---|---|---                ---|---|---"
    puts " #{board[6]} | #{board[7]} | #{board[8]}                  7 | 8 | 9 "
    puts "Enter a number where you want to place the letter."
  end
end
