require_relative 'displayable'
require_relative 'board'
require_relative 'thinkable'
require_relative 'player'

class Game
  include Displayable
  include Thinkable

  attr_accessor :player1, :player2, :board, :replay, :match_finished, :turns

  def initialize
    self.player1 = nil
    self.player2 = nil
    self.board = Board.new
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
    while game_replay?
      play_once
      prompt_replay
      game_end
    end
  end

  def game_replay?
    return replay
  end

  def play_once
    until match_finished || grid_filled?(board.grid)
      display_grid(board.grid)
      turns.odd? ? turn_msg(player1.name) : turn_msg(player2.name)
      turns.odd? ? place_token(player1) : place_token(player2)
      game_over?
      self.turns += 1
    end
  end

  # condition that checks whether a token exists below the position indicated by grid_pos in get_grid_position
  def place_token(player)
    pos_choice = get_grid_position(board.grid)
    board.update_grid(player, pos_choice)
    player.update_token_locations(pos_choice)
  end

  def game_over?
    p1_won = check_p_win(player1)
    p2_won = check_p_win(player2)
    if p1_won
      winner_msg(player1.name)
      match_finished = true
    elsif p2_won
      winner_msg(player2.name)
      match_finished = true
    elsif grid_filled?(board.grid)
      game_draw_msg
      match_finished = true
    end
  end

  # TODO: implement game-resetting and game-winning condition checking
  def prompt_replay
    replay_choice = get_decision
    replay = false if replay_choice == 'n'
  end

  def game_end
    replay ? game_reset : goodbye_msg
  end

  def game_reset
    self.turns = 1
    self.replay = true
    self.match_finished = false
    board.reset_grid
  end
end
