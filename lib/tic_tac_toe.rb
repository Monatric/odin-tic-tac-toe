require "pry-byebug"

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
  ].freeze

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
      board[take_user_input - 1] = "X"
      self.next_turn = player2
    elsif next_turn == player2
      board[take_user_input - 1] = "O"
      self.next_turn = player1
    end
  end

  def announce_winner
    if player_has_won? == true
      winner = next_turn == player1 ? "Player 2!" : "Player 1"
      puts "\nThe winner is #{winner}"
    else
      puts "It's a tie!"
    end
  end

  def take_user_input
    user_input_valid = false
    while user_input_valid == false
      coord = gets.chomp
      if letter_exists?(coord) == true
        puts "There's a letter already!"
      elsif one_to_nine?(coord) == false
        puts "That's not a number 1 to 9!"
      else
        user_input_valid = true
      end
    end
    coord.to_i
  end

  def letter_exists?(coord)
    board[coord.to_i - 1] != " "
  end

  def one_to_nine?(coord)
    coord.match?(/[1-9]/)
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
    puts "It is #{next_turn}'s turn." unless player_has_won?
  end

  def includes_spaces?
    board.include?(" ")
  end

  def check_combination
    # WIN_COMBI's 'e' acts as the index value for the board
    # #values_at takes these indices to find all possible combinations
    # join them and squeeze them to see if a letter consistently makes three
    WIN_COMBI.map { |e| board.values_at(e[0], e[1], e[2]).join.squeeze }
  end

  def player_has_won?
    # p(check_combination)
    check_combination.any? { |e| %w[X O].include?(e) }
  end
end
