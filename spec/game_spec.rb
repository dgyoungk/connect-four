require './lib/game.rb'
require './lib/thinkable.rb'

describe Game do
  subject(:new_game) { described_class.new }
  let(:new_p_name) { 'dummy' }
  describe '#setup' do
    before do
      allow(new_game).to receive(:welcome_msg)
      allow(new_game).to receive(:rules_msg)
      allow(new_game).to receive(:new_player_msg)
      allow(new_game).to receive(:display_grid)
    end
    context 'when method is called' do
      before do
        allow(new_game).to receive(:gets).and_return(new_p_name)
      end
      describe 'sets up the game' do
        it 'displays welcome mesage' do
          expect(new_game).to receive(:welcome_msg)
          new_game.setup
        end
        it'triggers #create_player twice' do
          expect(new_game).to receive(:create_player).twice
          new_game.setup
        end
        it 'explains the rules of the game' do
          expect(new_game).to receive(:rules_msg)
          new_game.setup
        end
        it 'displays the game grid' do
          expect(new_game).to receive(:display_grid)
          new_game.setup
        end
      end
    end
  end

  describe '#create_player' do
    let(:newcomer) { double('newcomer', name: "dummy") }
    let(:choice) { 'white' }
    let(:marker_choices) { double("marker_choices", black: "\u25EF", white: "\u25C9")}
    before do
      allow(new_game).to receive(:new_player_msg)
      allow(new_game).to receive(:error_msg)
      allow(new_game).to receive(:marker_msg)
    end
    context 'when method executes' do
      it 'triggers #assign_player' do
        allow(new_game).to receive(:gets).and_return(newcomer.name)
        expect(new_game).to receive(:assign_player).with(newcomer.name)
        new_game.create_player
      end
      xit 'triggers #choose_marker' do
        allow(new_game).to receive(:gets).and_return(choice)
        allow(new_game).to receive(:verify_choice).with(choice).and_return true
        expect(new_game).to receive(:choose_marker)
        new_game.create_player
      end
      context 'and there are no players in the game' do
        it 'creates player 1 first' do
          new_game.create_player
          expect(new_game.player1.name).to eq(newcomer.name)
        end
      end
      context 'and player 1 is already created' do
        before do
          new_game.instance_variable_set(:@player1, Player.new("Jojo"))
        end
        it 'creates player 2' do
          new_game.create_player
          expect(new_game.player2.name).to eq(newcomer.name)
        end
      end
    end
  end
end
