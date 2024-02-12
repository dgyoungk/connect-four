require_relative 'thinkable'

class Player
  include Thinkable

  attr_accessor :mark, :name, :placed

  def initialize(name, mark = nil)
    self.name = name
    self.mark = mark
    self.placed = []
  end

  def update_token_locations(position)
    self.placed.push(position)
  end
end
