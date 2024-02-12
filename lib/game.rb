require_relative 'displayable'
require_relative 'board'
require_relative 'thinkable'
require_relative 'player'

class Game
  include Displayable
  include Thinkable

  attr_accessor :player1, :player2, :grid, :replay, :match_finished, :turns

  def initialize
    self.player1 = nil
    self.player2 = nil
    self.grid = Board.new.grid
    self.replay = true
    self.match_finished = false
    self.turns = 1
  end

  def setup
    welcome_msg
    2.times { create_player }
    rules_msg
    grid_information_msg
    start_game
  end

  def create_player
    new_player_msg
    p_name = gets.chomp
    assign_player(p_name)
  end

  def assign_player(username)
    avail_markers = get_marker_choices.values
    if player1.nil? || player2.nil?
      player1.nil? ? self.player1 = Player.new(username, avail_markers.first) : self.player2 = Player.new(username, avail_markers.last)
    end
  end

  def start_game
    while replay
      play_once
      prompt_replay
      game_end
    end
  end

  def play_once
    until game_over? || grid_filled?(grid)
      display_grid(grid)
      turns.odd? ? turn_msg(player1) : turn_msg(player2)
      turns.odd? ? place_token(player1) : place_token(player2)
    end
  end

  # condition that checks whether a token exists below the position indicated by grid_pos in get_grid_position
  def place_token(player)
    pos_choice = get_grid_position
    grid.update_grid(player, pos_choice)
    player.update_token_locations(pos_choice)
  end

  # TODO: implement game-resetting and game-winning condition checking
  def prompt_replay
    return true
  end

  def game_end
    return false
  end

end
