require './lib/player.rb'


# things to test: change in state, input validation?
# TODO: test method #update_token_locations
describe Player do
  subject(:new_player) { described_class.new("Dummy") }
  let(:marker_choices) { double("marker_choices", red: "\u24C7", yellow: "\u24CE") }
end
