# insert class description
class TicTacToe
  def initialize
    @is_game_finished = false
    @player1 = "Player 1"
    @player2 = "Player 2"
    @next_turn = player1
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def start_game
    puts "The game has begun. It is Player 1's turn. Your letter is X."
    state_of_the_board
    take_coord
  end

  private

  attr_reader :player1, :player2
  attr_accessor :board, :next_turn

  def take_coord
    while includes_spaces? == true && check_combination == false
      coord = gets.chomp
      while coord.match?(/[1-9]/) == false
        puts "That's not a number 1 to 9!"
        coord = gets.chomp
      end

      if next_turn == player1
        board[coord.to_i - 1] = "X"
        self.next_turn = player2
      elsif next_turn == player2
        board[coord.to_i - 1] = "O"
        self.next_turn = player1
      end
      state_of_the_board
    end
  end

  def state_of_the_board
    puts "The current board             Guide"
    puts " #{board[0]} | #{board[1]} | #{board[2]}                  1 | 2 | 3 "
    puts "---|---|---                ---|---|---"
    puts " #{board[3]} | #{board[4]} | #{board[5]}                  4 | 5 | 6 "
    puts "---|---|---                ---|---|---"
    puts " #{board[6]} | #{board[7]} | #{board[8]}                  7 | 8 | 9 "
    puts " "
    print "Enter a number where you want to place the letter: "
  end

  def includes_spaces?
    board.include?(" ")
  end

  def check_combination
    if board.values_at(0, 1, 2).join.squeeze == ("X" || "O")
      true
    elsif board.values_at(3, 4, 5).join.squeeze == ("X" || "O")
      true
    elsif board.values_at(6, 7, 8).join.squeeze == ("X" || "O")
      true
    elsif board.values_at(0, 3, 6).join.squeeze == ("X" || "O")
      true
    elsif board.values_at(1, 4, 7).join.squeeze == ("X" || "O")
      true
    elsif board.values_at(2, 5, 8).join.squeeze == ("X" || "O")
      true
    elsif board.values_at(0, 4, 8).join.squeeze == ("X" || "O")
      true
    elsif board.values_at(2, 4, 6).join.squeeze == ("X" || "O")
      true
    else
      false
    end
  end
end
