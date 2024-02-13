require './lib/game.rb'

describe Game do
  subject(:new_game) { described_class.new }
  let(:new_player) { instance_double(Player, name: 'dummy') }
  let(:dummy_position) { 40 }
  describe '#setup' do
    before do
      new_game.instance_variable_set(:@replay, false)
      allow(new_game).to receive(:display_grid)
      allow(new_game).to receive(:welcome_msg)
      allow(new_game).to receive(:rules_msg)
      allow(new_game).to receive(:new_player_msg)
      allow(new_game).to receive(:grid_information_msg)
      allow(new_game).to receive(:grid_position_msg)
    end
    context 'when method is called' do
      it 'displays welcome mesage' do
        expect(new_game).to receive(:welcome_msg)
        new_game.setup
      end
      it 'triggers #create_player twice' do
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
    context 'when replay is true' do
      before do
        decision = 'n'
        allow(new_game).to receive(:play_once)
        allow(new_game).to receive(:get_decision).and_return(decision)
        allow(new_game).to receive(:replay_game?).and_return(true, false)
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

  describe '#play_once' do
    let(:galio) { double('galio', name: 'galio') }
    context 'when grid_filled returns false once' do
      before do
        new_game.instance_variable_set(:@player1, Player.new(galio.name))
        allow(new_game).to receive(:grid_filled?).with(new_game.board.grid).and_return(false, true)
        allow(new_game).to receive(:display_grid).with(new_game.board.grid)
        allow(new_game).to receive(:turn_msg).with(galio.name)
        allow(new_game).to receive(:place_token).with(new_game.player1)
        allow(new_game).to receive(:check_game_status)
      end
      it '#display_grid executes once' do
        expect(new_game).to receive(:display_grid).with(new_game.board.grid).once
        new_game.play_once
      end
      it '#turn_msg does executes once' do
        expect(new_game).to receive(:turn_msg).with(galio.name).once
        new_game.play_once
      end
      it '#place_token executes once' do
        expect(new_game).to receive(:place_token).with(new_game.player1).once
        new_game.play_once
      end
      it '#check_game_status executes once' do
        expect(new_game).to receive(:check_game_status).once
        new_game.play_once
      end
      it 'turn increments by 1' do
        expect { new_game.play_once }.to change { new_game.turn }.to (2)
      end
    end
  end

  describe '#grid_filled?' do
    context 'when the grid has one empty slot' do
      let(:token) { "\u24CE" }
      before do
        41.times do |n|
          new_game.board.grid[n + 1] = token
        end
      end
      it 'returns false' do
        expect(new_game).to receive(:grid_filled?).with(new_game.board.grid).and_return false
        new_game.grid_filled?(new_game.board.grid)
      end
      context 'when the grid has no empty slots' do
        before do
          new_game.board.grid.each { |k, v| v = token }
        end
        it 'returns true' do
          expect(new_game).to receive(:grid_filled?).with(new_game.board.grid).and_return true
          new_game.grid_filled?(new_game.board.grid)
        end
      end
    end
  end

  describe '#place_token' do
    context 'when method executes' do
      let(:dummy_position) { 40 }
      before do
        new_game.instance_variable_set(:@player1, Player.new('dummy'))
        allow(new_game).to receive(:get_grid_position).with(new_game.board.grid).and_return(dummy_position)
        allow(new_game.board).to receive(:update_grid).with(new_game.player1, dummy_position)
        allow(new_game.player1).to receive(:update_token_locations).with(dummy_position)
      end
      it 'triggers #get_grid_position' do
        expect(new_game).to receive(:get_grid_position).with(new_game.board.grid)
        new_game.place_token(new_game.player1)
      end
      it 'triggers update_grid on the board' do
        expect(new_game.board).to receive(:update_grid).with(new_game.player1, dummy_position)
        new_game.place_token(new_game.player1)
      end
      it 'triggers #update_token_locations on the player' do
        expect(new_game.player1).to receive(:update_token_locations).with(dummy_position)
        new_game.place_token(new_game.player1)
      end
    end
  end

  describe '#check_game_status' do
    before do
      new_game.instance_variable_set(:@player1, Player.new("wingus"))
      new_game.instance_variable_set(:@player2, Player.new("dingus"))
      allow(new_game).to receive(:game_draw_msg)
      allow(new_game).to receive(:winner_msg).with(new_game.player1.name)
      allow(new_game).to receive(:winner_msg).with(new_game.player2.name)
    end
    context 'when method executes' do
      before do
        allow(new_game).to receive(:grid_filled?).with(new_game.board.grid)
      end
      it 'triggers #check_p_win for player 1' do
        allow(new_game).to receive(:check_p_win).with(new_game.player2)
        expect(new_game).to receive(:check_p_win).with(new_game.player1)
        new_game.check_game_status
      end
      it 'and for player 2' do
        allow(new_game).to receive(:check_p_win).with(new_game.player1)
        expect(new_game).to receive(:check_p_win).with(new_game.player2)
        new_game.check_game_status
      end
    end
    context 'when neither player won and grid is filled' do
      before do
        allow(new_game).to receive(:grid_filled?).with(new_game.board.grid).and_return true
      end
      it 'triggers #game_draw_msg' do
        expect(new_game).to receive(:game_draw_msg)
        new_game.check_game_status
      end
      context 'when player 1 wins' do
        before do
          allow(new_game).to receive(:check_p_win).with(new_game.player1).and_return true
          allow(new_game).to receive(:check_p_win).with(new_game.player2).and_return false
        end
        it "triggers #winner_msg with player 1's name" do
          expect(new_game).to receive(:winner_msg).with(new_game.player1.name)
          new_game.check_game_status
        end
      end
      context 'when player 2 wins' do
        before do
          allow(new_game).to receive(:check_p_win).with(new_game.player1).and_return false
          allow(new_game).to receive(:check_p_win).with(new_game.player2).and_return true
        end
        it "triggers #winner_msg with player 2's name" do
          expect(new_game).to receive(:winner_msg).with(new_game.player2.name)
          new_game.check_game_status
        end
      end
      it 'indicates that a match is finished' do
        expect { new_game.check_game_status }.to change { new_game.match_finished }.to be true
      end
    end
  end

  describe '#prompt_replay' do
    let(:player_choice) { 'n' }
    before do
      allow(new_game).to receive(:replay_msg)
      allow(new_game).to receive(:error_msg)
    end
    context 'when method executes' do
      before do
        allow(new_game).to receive(:gets).and_return(player_choice)
        allow(new_game).to receive(:decision_verified?).with(player_choice).and_return true
      end
      it 'triggers #get_decision' do
        expect(new_game).to receive(:get_decision)
        new_game.prompt_replay
      end
      context "if player's choice is n" do
        it 'unsets the replay flag' do
          expect { new_game.prompt_replay }.to change { new_game.replay }.to false
        end
      end
    end
  end
  describe '#game_end' do
    context 'when the replay flag is not changed' do
      it 'triggers #game_reset' do
        expect(new_game).to receive(:game_reset)
        new_game.game_end
      end
    end
    context 'when the replay flag is changed' do
      before do
        new_game.instance_variable_set(:@replay, false)
      end
      it 'triggers #goodbye_msg' do
        expect(new_game).to receive(:goodbye_msg)
        new_game.game_end
      end
    end
  end
  describe '#game_reset' do
    context 'when method executes' do
      before do
        new_game.instance_variable_set(:@turn, 14)
        new_game.instance_variable_set(:@replay, false)
        new_game.instance_variable_set(:@match_finished, true)
      end
      it "resets the game's turn count to 1" do
        expect { new_game.game_reset }.to change { new_game.turn }.to 1
      end
      it "resets the replay flag" do
        expect { new_game.game_reset }.to change { new_game.replay }.to true
      end
      it "resets the match_finished flag" do
        expect { new_game.game_reset }.to change { new_game.match_finished }.to false
      end
      it 'triggers #reset_grid on the game board' do
        expect(new_game.board).to receive(:reset_grid)
        new_game.game_reset
      end
    end
  end
end
