require './lib/game.rb'

describe Game do
  subject(:new_game) { described_class.new }
  let(:new_player) { instance_double(Player, name: 'dummy') }
  describe '#setup' do
    before do
      allow(new_game).to receive(:display_grid)
      allow(new_game).to receive(:welcome_msg)
      allow(new_game).to receive(:rules_msg)
      allow(new_game).to receive(:new_player_msg)
      new_game.instance_variable_set(:@player1, Player.new('dummy', "\u25EF"))
      allow(new_game).to receive(:turn_msg).with(new_game.player1)
    end
    context 'when method is called' do
      before do
        allow(new_game).to receive(:gets).and_return(new_player.name)
      end
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
      it 'triggers #start_game' do
        expect(new_game).to receive(:start_game)
        new_game.setup
      end
    end
  end

  describe '#create_player' do
    let(:newcomer) { double('newcomer', name: "dummy") }
    before do
      allow(new_game).to receive(:gets).and_return(newcomer.name)
      allow(new_game).to receive(:new_player_msg)
      allow(new_game).to receive(:error_msg)
    end
    context 'when method executes' do
      it 'triggers #assign_player' do
        expect(new_game).to receive(:assign_player).with(newcomer.name)
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

  describe '#assign_player' do
    let(:tokens) { double("marker_choices", black: "\u25EF", white: "\u25C9") }
    let(:jayce) { double('jayce', name: 'jayce') }
    context 'when players are being assigned a token' do
      it 'assigns a token to the player' do
        new_game.assign_player(jayce.name)
        expect(new_game.player1.mark).not_to be_nil
      end
      context 'and a player already exists' do
        before do
          new_game.instance_variable_set(:@player1, Player.new("Jojo"))
        end
        it 'assigns a token to the other player' do
          new_game.assign_player(jayce.name)
          expect(new_game.player2.mark).not_to be_nil
        end
      end
    end
  end

  # TODO: debug tests related to #start_game and #play_once
  describe '#start_game' do
    let(:olaf) { double('olaf', name: 'olaf') }
    context 'when replay is true' do
      before do
        allow(new_game).to receive(:grid_filled?).with(new_game.grid).and_return true
        new_game.instance_variable_set(:@match_finished, true)
        allow(new_game).to receive(:turn_msg).with(olaf)
      end
      it 'triggers #play_once' do
        expect(new_game).to receive(:play_once)
        new_game.start_game
      end
      it 'triggers #prompt_replay' do
        expect(new_game).to receive(:prompt_replay)
        new_game.start_game
      end
      it 'triggers #game_end' do
        expect(new_game).to receive(:game_end)
        new_game.start_game
      end
    end
    context 'when replay is false' do
      before do
        new_game.instance_variable_set(:@replay, false)
      end
      it 'does not trigger #play_once' do
        expect(new_game).not_to receive(:play_once)
      end
      it 'does not trigger #prompt_replay' do
        expect(new_game).not_to receive(:prompt_replay)
      end
      it 'does not trigger #game_end' do
        expect(new_game).not_to receive(:game_end)
      end
    end
  end
end
