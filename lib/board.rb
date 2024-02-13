class Board

  attr_accessor :grid

  def initialize
    self.grid = grid_init
  end

  def grid_init
    game_grid = 43.times.with_object(Hash.new) do |n, hash|
      next if n == 0
      if n <= 9
        hash[n] = %(0#{n})
      else
        hash[n] = n.to_s
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
