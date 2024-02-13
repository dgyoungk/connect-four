class Board

  attr_accessor :grid

  def initialize
    self.grid = grid_init
  end

  def grid_init
    game_grid = 42.times.with_object(Hash.new) { |n, hash| hash[n + 1] = "\u25EF" }
  end

  def reset_grid
    self.grid.each { |k, v| v = "\u25EF" }
  end

  def update_grid(player, position)
    grid[position] = player.mark
  end
end
