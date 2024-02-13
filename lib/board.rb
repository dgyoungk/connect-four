# frozen_string_literal: false

# ./lib/board.rb
class Board
  attr_accessor :grid

  def initialize
    self.grid = grid_init
  end

  def grid_init
    43.times.with_object({}) do |n, hash|
      next if n.zero?

      hash[n] = if n <= 9
                  %(0#{n})
                else
                  n.to_s
                end
    end
  end

  def reset_grid
    self.grid = grid_init
  end

  def update_grid(player, position)
    grid[position.to_i] = %(#{player.mark} )
  end
end
