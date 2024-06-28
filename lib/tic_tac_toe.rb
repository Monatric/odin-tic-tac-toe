require "pry-byebug"
require "colorize"

# insert class description
class TicTacToe
  WIN_COMBI = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    @is_game_finished = false
    @player1 = "Player 1"
    @player2 = "Player 2"
    @next_turn = player1
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def start_game
    state_of_the_board
    place_letter
  end

  private

  attr_reader :player1, :player2
  attr_accessor :board, :next_turn

  def place_letter
    while includes_spaces? == true && player_has_won? == false
      check_next_turn
      state_of_the_board
    end
    announce_winner
  end

  def check_next_turn
    if next_turn == player1
      board[take_user_input - 1] = "X".colorize(:red)
      self.next_turn = player2
    elsif next_turn == player2
      board[take_user_input - 1] = "O".colorize(:blue)
      self.next_turn = player1
    end
  end

  def announce_winner
    if player_has_won? == true
      winner = next_turn == player1 ? "Player 2!" : "Player 1"
      puts "\nThe winner is #{winner}"
    else
      #binding.pry
      puts "It's a tie!"
    end
  end

  def take_user_input
    coord = gets.chomp
    loop do
      if coord.match?(/[1-9]/) == false
        puts "That's not a number 1 to 9!"
        coord = gets.chomp
      elsif board[coord.to_i - 1] == "X" || board[coord.to_i - 1] == "O"
        puts "There's a letter already!"
        coord = gets.chomp
      end
      break if coord.match?(/[1-9]/) == true && (board[coord.to_i - 1] != "X" && board[coord.to_i - 1] != "O")
    end
    coord.to_i
  end

  def state_of_the_board
    puts "The current board\t   Guide"
    9.times do |num|
      print " #{board[num]} "
      print "|" if num != 2 && num != 5 && num != 8
      case num
      when 2
        print "\t\t 1 | 2 | 3\n"
        puts "---|---|---\t\t---|---|---"
      when 5
        print "\t\t 4 | 5 | 6\n"
        puts "---|---|---\t\t---|---|---"
      when 8
        print "\t\t 7 | 8 | 9\n"
      end
    end
    puts "The game has begun. It is #{next_turn}'s turn."
  end

  def includes_spaces?
    board.include?(" ")
  end

  def check_combination
    WIN_COMBI.map { |e| board.values_at(e[0], e[1], e[2]).join.squeeze }
  end

  def player_has_won?
    check_combination.any? { |e| %w[X O].include?(e) }
  end
end
