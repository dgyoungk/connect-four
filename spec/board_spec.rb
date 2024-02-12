require './lib/board.rb'

describe Board do
  subject(:new_board) { described_class.new }
  let(:player) { double('player', name: "dummy", mark: "\u25EF") }
  let(:desired_board_pos) { 5 }
  describe '#initialize' do
    context 'when a new instance is created' do
      it 'creates a grid of size 42' do
        expect(new_board.grid.size).to eq 42
      end
    end
  end
  describe '#update_board' do
    context 'when a player marks a place on a grid' do
      it 'updates the board hash' do
        expect { new_board.update_grid(player, desired_board_pos) }.to change { new_board.grid[desired_board_pos] }.to (player.mark)
      end
    end
  end
end
