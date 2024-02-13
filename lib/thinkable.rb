# frozen_string_literal: false

require_relative 'displayable'

# this module will house all helper and logic-related methods
# such as user input, condition-checking, etc...
module Thinkable
  include Displayable

  def game_win_cons
    win_cons = []
    # horizontal win conditions
    43.times do |n|
      next if n.zero?

      next unless n.between?(1, 4) ||
                  n.between?(8, 11) ||
                  n.between?(15, 18) ||
                  n.between?(22, 25) ||
                  n.between?(29, 32) ||
                  n.between?(36, 39)

      win_cons << ((n)..(n + 3)).to_a
    end
    # vertical and half of diagonal conditions
    22.times do |n|
      next if n.zero?

      win_cons << [n, n + 6, n + 12, n + 18] if n.between?(4, 7) || n.between?(11, 14) || n.between?(18, 21)
      win_cons << [n, n + 7, n + 14, n + 21]
    end
    # rest of diagonal conditions
    19.times do |n|
      next if n.zero?

      win_cons << [n, n + 8, n + 16, n + 24] if n.between?(1, 4) || n.between?(8, 11) || n.between?(15, 18)
    end
    win_cons
  end

  def token_choices
    { 'red' => "\u24C7", 'yellow' => "\u24CE" }
  end

  def verify_choice(input)
    %w[black white].include?(input)
  end

  def grid_filled?(grid)
    grid.all? do |k, v|
      v != if k < 10
             %(0#{k})
           else
             k.to_s
           end
    end
  end

  def user_grid_position(grid)
    grid_position_msg
    player_choice = gets.chomp
    until position_verified?(player_choice, grid)
      error_msg
      grid_position_msg
      player_choice = gets.chomp
    end
    player_choice
  end

  def position_verified?(position, grid)
    tokens = token_choices.values
    unless position.to_i.between?(36, 42)
      return grid[position.to_i + 7] == %(#{tokens.first} ) || grid[position.to_i + 7] == %(#{tokens.last} )
    end

    return grid[position.to_i] == %(0#{position}) if position.to_i < 10

    grid[position.to_i] == position
  end

  def player_won?(player, combos)
    combos.any? { |win_con| win_con.intersection(player.placed) == win_con }
  end

  def user_decision
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
    %w[y n].include?(p_choice)
  end
end
