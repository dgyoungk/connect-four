class Board

  attr_accessor :grid

  def initialize
    self.grid = grid_init
  end

  def grid_init
    game_grid = 43.times.with_object(Hash.new) do |n, hash|
      next if n == 0
      hash[n] = n
    end
  end

  def reset_grid
    self.grid.each { |k, v| grid[k] = k }
  end

  def update_grid(player, position)
    grid[position] = %(#{player.mark} )
  end
end
