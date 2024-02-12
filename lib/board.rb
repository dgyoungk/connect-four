class Board

  attr_accessor :grid

  def initialize
    self.grid = grid_init
  end

  def grid_init
    game_grid = 42.times.with_object(Hash.new) { |n, hash| hash[n + 1] = ' ' }
  end

  def update_grid(player, position)
    grid[position] = player.mark
  end
end
