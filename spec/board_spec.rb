# frozen_string_literal: false

require './lib/board'

describe Board do
  subject(:new_board) { described_class.new }
  let(:player) { double('player', name: 'dummy', mark: "\u24C7") }
  let(:desired_board_pos) { 5 }
  describe '#initialize' do
    context 'when a new instance is created' do
      it 'creates a grid of size 42 via #grid_init' do
        expect(new_board.grid.size).to eq 42
      end
    end
  end
  describe '#update_board' do
    context 'when a player marks a place on a grid' do
      it 'updates the board grid' do
        new_board.update_grid(player, desired_board_pos)
        expect(new_board.grid[desired_board_pos]).to eq %(#{player.mark} )
      end
    end
  end
  describe '#reset_grid' do
    context 'when method executes' do
      let(:comparing_board) { described_class.new }
      it 'sets the grid to its initial state' do
        new_board.reset_grid
        expect(comparing_board.grid).to eq(new_board.grid)
      end
    end
  end
end
