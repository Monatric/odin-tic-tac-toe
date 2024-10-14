require_relative '../lib/tic_tac_toe'
# when the #check_combination's array contains a value \"X\" (save for later)

describe TicTacToe do
  subject(:game) { described_class.new }
  describe '#player_has_won?' do
    context 'when the board shows a straight three X' do
      before do
        allow(game).to receive(:check_combination).and_return(['X'])
      end
      it 'returns true' do
        result = game.player_has_won?
        expect(result).to be true
      end
    end

    context 'when the board shows a straight three O' do
      before do
        allow(game).to receive(:check_combination).and_return(['O'])
      end
      it 'returns true' do
        result = game.player_has_won?
        expect(result).to be true
      end
    end

    context 'when the board does not have straight three letters' do
      before do
        allow(game).to receive(:check_combination).and_return([' '])
      end
      it 'returns false' do
        result = game.player_has_won?
        expect(result).to be false
      end
    end
  end

  describe '#check_next_turn' do
    context 'when the current player is player1' do
      before do
        allow(game).to receive(:take_user_input).and_return(5)
      end

      it 'switches the next turn to player2' do
        player2 = game.instance_variable_get(:@player2)
        game.check_next_turn
        expect(game.next_turn).to be(player2)
      end
    end

    context 'when the current player is player2' do
      before do
        allow(game).to receive(:take_user_input).and_return(5)
      end

      it 'switches the next turn to player1' do
        player1 = game.instance_variable_get(:@player1)
        game.instance_variable_set(:@next_turn, 'Player 2')
        game.check_next_turn
        expect(game.next_turn).to be(player1)
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
end
