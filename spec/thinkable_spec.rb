require './lib/thinkable.rb'

describe Thinkable do
  include Thinkable
  describe '#get_game_win_cons' do
    let(:combos) { get_game_win_cons }
    it 'returns an array of size 69' do
      expect(combos.size).to eq(69)
    end
    it 'each element is an array' do
      expect(combos).to all be_an_instance_of Array
    end
  end
  describe '#get_token_choices' do
    let(:choices) { get_token_choices }
    it 'returns a hash' do
      expect(choices).to be_an_instance_of Hash
    end
    it 'has a size of 2' do
      expect(choices.size).to eq (2)
    end
  end
end
