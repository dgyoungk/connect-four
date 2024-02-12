require './lib/player.rb'


# things to test: change in state, input validation?
describe Player do
  subject(:new_player) { described_class.new("Dummy") }
  let(:marker_choices) { double("marker_choices", black: "\u25EF", white: "\u25C9")}
  let(:choice) { "black" }
  describe '#designate_marker' do
    context 'when method is called' do
      it 'assigns the token color to the player' do
        expect { new_player.designate_marker(choice) }.to change { new_player.mark }.to marker_choices.black
      end
    end
  end
end
