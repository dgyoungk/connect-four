# frozen_string_literal: false

require './lib/player'

# things to test: change in state, input validation?
describe Player do
  subject(:new_player) { described_class.new('Dummy') }
  let(:token_position) { 5 }
  describe '#update_token_locations' do
    context 'when method executes' do
      it 'stores the token position in the placed array' do
        new_player.update_token_locations(token_position)
        expect(new_player.placed).to include(token_position)
      end
    end
  end
end
