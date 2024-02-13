require './lib/player.rb'


# things to test: change in state, input validation?
# TODO: test method #update_token_locations
describe Player do
  subject(:new_player) { described_class.new("Dummy") }
  let(:token_position) { 5 }
  describe '#update_token_locations' do
    context 'when method executes' do
      it 'stores the token position in the placed array' do
        expect { new_player.update_token_locations(token_position) }.to change { new_player.placed }.to include(token_position)
      end
    end
  end
end
