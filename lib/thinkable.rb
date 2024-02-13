require_relative 'displayable'

# this module will house all helper and logic-related methods
# such as user input, condition-checking, etc...
module Thinkable
  include Displayable

  def get_game_win_cons
    win_cons = []
    # horizontal win conditions
    43.times do |n|
      next if n == 0
      if n.between?(1, 4) || n.between?(8, 11) || n.between?(15, 18) || n.between?(22, 25) || n.between?(29, 32) || n.between?(36, 39)
        win_cons << ((n)..(n + 3)).to_a
      end
    end
    # vertical and half of diagonal conditions
    22.times do |n|
      next if n == 0
      if n.between?(4, 7) || n.between?(11, 14) || n.between?(18, 21)
        win_cons << [n, n + 6, n + 12, n + 18]
      end
      win_cons << [n, n + 7, n + 14, n + 21]
    end
    # rest of diagonal conditions
    19.times do |n|
      next if n == 0
      if n.between?(1, 4) || n.between?(8, 11) || n.between?(15, 18)
        win_cons << [n, n + 8, n + 16, n + 24]
      end
    end
    win_cons
  end

  def get_token_choices
    return { "red" => "\u24C7", 'yellow' => "\u24CE" }
  end

  def verify_choice(input)
    return input == 'black' || input == 'white'
  end

  def grid_filled?(grid)
    return grid.all? { |k, v| v != k }
  end

  def get_grid_position(grid)
    grid_position_msg
    player_choice = gets.to_i
    until position_verified?(player_choice, grid)
      error_msg
      grid_position_msg
      player_choice = gets.to_i
    end
    player_choice
  end

  def position_verified?(position, grid)
    tokens = get_token_choices.values
    unless position.between?(36, 42)
      return grid[position + 7] == %(#{tokens.first} ) || grid[position + 7] == %(#{tokens.last} )
    else
      true
    end
  end

  def player_won?(player, combos)
    combos.any? { |win_con| win_con.intersection(player.placed) == win_con }
  end

  def get_decision
    replay_msg
    decision = gets.chomp.downcase
    until decision_verified?(decision)
      error_msg
      replay_msg
      decision = gets.chomp.downcase
    end
    decision
  end

  def decision_verified?(p_choice)
    return p_choice == 'y' || p_choice == 'n'
  end
end
