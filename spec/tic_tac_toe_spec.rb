require_relative '../lib/tic_tac_toe'

describe TicTacToe do
  subject(:game) { described_class.new }
  describe '#player_has_won?' do
    context 'when the board shows a straight three X' do
      before do
        game.instance_variable_set(:@board, ['X', 'X', 'X',
                                             'O', 'O', ' ',
                                             ' ', ' ', ' '])
      end
      it 'returns true' do
        result = game.player_has_won?
        expect(result).to be true
      end
    end

    context 'when the board shows a straight three O' do
      before do
        game.instance_variable_set(:@board, ['X', 'X', 'O',
                                             'O', 'O', 'X',
                                             'O', 'X', ' '])
      end
      it 'returns true' do
        result = game.player_has_won?
        expect(result).to be true
      end
    end

    context 'when the board does not have straight three letters' do
      before do
        game.instance_variable_set(:@board, %w[X X O
                                               O O X
                                               X X O])
      end
      it 'returns false' do
        result = game.player_has_won?
        expect(result).to be false
      end
    end
  end

  describe '#check_next_turn' do
    context 'when the current player is player1' do
      let(:valid_input) { 5 }
      before do
        allow(game).to receive(:take_user_input).and_return(valid_input)
      end

      it 'switches the next turn to player2' do
        player2 = game.instance_variable_get(:@player2)
        game.check_next_turn
        expect(game.next_turn).to be(player2)
      end

      it 'updates the board' do
        game.check_next_turn
        expect(game.board[valid_input - 1]).to eq('X')
      end
    end

    context 'when the current player is player2' do
      let(:valid_input) { 3 }

      before do
        allow(game).to receive(:take_user_input).and_return(valid_input)
      end

      it 'switches the next turn to player1' do
        player1 = game.instance_variable_get(:@player1)
        game.instance_variable_set(:@next_turn, 'Player 2')
        game.check_next_turn
        expect(game.next_turn).to be(player1)
      end

      it 'updates the board' do
        game.instance_variable_set(:@next_turn, 'Player 2')
        game.check_next_turn
        expect(game.board[valid_input - 1]).to eq('O')
      end
    end
  end

  describe '#take_user_input' do
    context 'when a user chooses a spot that contains a letter once, then a valid input' do
      let(:invalid_choice) { '1' }
      let(:valid_choice) { '2' }

      before do
        board = game.board

        board[0] = 'X'
        board[1] = ' '
        allow(game).to receive(:gets).and_return(invalid_choice, valid_choice)
      end

      it 'completes loop and displays that there is a letter already once' do
        error_msg = "There's a letter already!"

        expect(game).to receive(:puts).with(error_msg).once
        game.take_user_input
      end

      it 'completes loop and returns a sanitized input' do
        expect(game.take_user_input).to eq(valid_choice.to_i)
      end
    end

    context 'when a user input is not between 1 to 9 first, then between 1 to 9 second' do
      let(:invalid_choice) { '0' }
      let(:valid_choice) { '3' }

      before do
        allow(game).to receive(:gets).and_return(invalid_choice, valid_choice)
      end

      it 'completes loop and displays an error message not being one to nine' do
        error_msg = "That's not a number 1 to 9!"
        expect(game).to receive(:puts).with(error_msg).once
        game.take_user_input
      end

      it 'completes loop and returns a sanitized input' do
        expect(game.take_user_input).to eq(valid_choice.to_i)
      end
    end
  end

  describe '#announce_winner' do
    context 'when there are no winners' do
      before do
        allow(game).to receive(:player_has_won?).and_return(false)
      end

      it 'prints a message about tie' do
        tie_message = "It's a tie!"
        expect(game).to receive(:puts).with(tie_message)
        game.announce_winner
      end
    end

    context 'when the winner is Player 1' do
      before do
        player2 = game.instance_variable_get(:@player2)
        allow(game).to receive(:player_has_won?).and_return(true)
        allow(game).to receive(:next_turn).and_return(player2)
      end

      it 'declares that the winner is Player 1' do
        winner = "\nThe winner is Player 1"
        expect(game).to receive(:puts).with(winner)
        game.announce_winner
      end
    end

    context 'when the winner is Player 2' do
      before do
        player1 = 'Player 1'
        allow(game).to receive(:player_has_won?).and_return(true)
        allow(game).to receive(:next_turn).and_return(player1)
      end

      it 'declares that the winner is Player 2' do
        winner = "\nThe winner is Player 2"
        expect(game).to receive(:puts).with(winner)
        game.announce_winner
      end
    end
  end

  describe '#letter_exists?' do
    context 'when a chosen spot has a letter' do
      before do
        board = game.board
        board[0] = 'X'
      end

      it 'returns true' do
        # the coord 1 is essentially index 0 because of subtraction
        coord = 1
        result = game.letter_exists?(coord)
        expect(result).to be true
      end
    end

    context 'when a chosen spot does not have a letter' do
      before do
        board = game.board
        board[0] = ' '
      end

      it 'returns false' do
        # the coord 1 is essentially index 0 because of subtraction
        coord = 1
        result = game.letter_exists?(coord)
        expect(result).to be false
      end
    end
  end

  describe '#one_to_nine?' do
    context 'when the choice is within 1-9' do
      it 'returns true' do
        choice = '7'
        result = game.one_to_nine?(choice)
        expect(result).to be true
      end
    end

    context 'when the choice is not within 1-9' do
      it 'returns false for numbers over 9' do
        choice = '12'
        result = game.one_to_nine?(choice)
        expect(result).to be false
      end

      it 'returns false for numbers less than 1' do
        choice = '-5'
        result = game.one_to_nine?(choice)
        expect(result).to be false
      end
    end
  end

  describe '#includes_spaces?' do
    it 'returns true if there are spaces in the board' do
      game.instance_variable_set(:@board, [' ', ' ', ' '])
      expect(game).to be_includes_spaces
    end

    it 'returns true if there are spaces and letters in the board' do
      game.instance_variable_set(:@board, [' ', 'X', ' '])
      expect(game).to be_includes_spaces
    end

    it 'returns false if the board is full of letters' do
      game.instance_variable_set(:@board, %w[X X X])
      expect(game).to_not be_includes_spaces
    end
  end

  describe '#check_combination' do
    # not sure how to test this or if I need to anyway
  end

  describe '#state_of_the_board' do
    # no need for tests because it's just for displaying
  end

  describe '#place_letter' do
    # no need for tests because what  was it called? a public script method
  end

  describe '#start_game' do
    # same issue for #place_letter
  end
end
