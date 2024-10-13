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
end
