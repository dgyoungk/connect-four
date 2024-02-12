require_relative 'displayable'
require_relative 'board'
require_relative 'thinkable'
require_relative 'player'

class Game
  include Displayable
  include Thinkable

  attr_accessor :player1, :player2, :grid

  def initialize
    self.player1 = nil
    self.player2 = nil
    self.grid = Board.new.grid
  end

  def setup
    welcome_msg
    rules_msg
    2.times { create_player }
  end

  def create_player
    new_player_msg
    p_name = gets.chomp
    player_token = choose_marker
    assign_player(p_name, player_token)
  end

  def assign_player(username, token)
    if player1.nil? || player2.nil?
      player1.nil? ? self.player1 = Player.new(username, token) : self.player2 = Player.new(username, token)
    end
  end

end
