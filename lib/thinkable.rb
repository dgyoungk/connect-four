require_relative 'displayable'

# this module will house all helper and logic-related methods
# such as user input, condition-checking, etc...
module Thinkable
  include Displayable

  def empty_token
    return "\u25EF"
  end

  def get_marker_choices
    return { "red" => "\u24C7", 'yellow' => "\u24CE" }
  end

  def verify_choice(input)
    return input == 'black' || input == 'white'
  end

  def grid_filled?(grid)
    return grid.all? { |k, v| v != empty_token }
  end

  # TODO: determine where I want to put the get_grid_position method
  def position_verified?(position)
    unless position.between?(1, 7)
      return grid[position - 7] != player1.mark && grid[position- - 7] != player2.mark
    else
      true
    end
  end

  def get_grid_position
    grid_position_msg
    player_choice = gets.chomp.to_i
    until position_verified?(player_choice)
      error_msg
      grid_position_msg
    end
    player_choice
  end
end
