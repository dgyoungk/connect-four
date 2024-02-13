# frozen_string_literal: false

require_relative 'thinkable'

class Player
  include Thinkable

  attr_accessor :mark, :name, :placed

  def initialize(name, mark = nil, placed = [])
    self.name = name
    self.mark = mark
    self.placed = placed
  end

  def update_token_locations(position)
    placed.push(position.to_i)
  end
end
