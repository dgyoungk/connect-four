# frozen_string_literal: false

require_relative 'displayable'
require_relative 'board'
require_relative 'thinkable'
require_relative 'player'

# ./lib/game.rb
class Game
  include Displayable
  include Thinkable

  attr_accessor :player1, :player2, :board, :replay, :match_finished, :turn, :win_combos

  def initialize
    self.player1 = nil
    self.player2 = nil
    self.board = Board.new
    self.replay = true
    self.match_finished = false
    self.turn = 1
  end

  def setup
    welcome_msg
    2.times { create_player }
    rules_msg
    start_game
  end

  def create_player
    new_player_msg
    p_name = gets.chomp
    assign_player(p_name)
  end

  def assign_player(username)
    avail_markers = token_choices.values
    return unless player1.nil? || player2.nil?

    if player1.nil?
      self.player1 = Player.new(username,
                                avail_markers.first)
    else
      self.player2 = Player.new(username,
                                avail_markers.last)
    end
  end

  def start_game
    while replay_game?
      play_once
      prompt_replay
      game_end
    end
  end

  def replay_game?
    replay
  end

  def play_once
    until match_finished || grid_filled?(board.grid)
      display_grid(board.grid)
      turn.odd? ? turn_msg(player1.name) : turn_msg(player2.name)
      turn.odd? ? place_token(player1) : place_token(player2)
      check_game_status
      self.turn += 1
    end
    display_grid(board.grid)
  end

  # condition that checks whether a token exists below the position indicated by grid_pos in user_grid_position
  def place_token(player)
    pos_choice = user_grid_position(board.grid)
    board.update_grid(player, pos_choice)
    player.update_token_locations(pos_choice)
  end

  def check_game_status
    self.win_combos = game_win_cons
    p1_won = player_won?(player1, win_combos)
    p2_won = player_won?(player2, win_combos)
    if p1_won
      self.match_finished = true
      winner_msg(player1.name)
    elsif p2_won
      self.match_finished = true
      winner_msg(player2.name)
    elsif grid_filled?(board.grid)
      self.match_finished = true
      game_draw_msg
    end
  end

  def prompt_replay
    replay_choice = user_decision
    self.replay = false if replay_choice == 'n'
  end

  def game_end
    replay ? game_reset : goodbye_msg
  end

  def game_reset
    self.turn = 1
    self.replay = true
    self.match_finished = false
    player1.placed = []
    player2.placed = []
    board.reset_grid
    another_round_msg
  end
end
