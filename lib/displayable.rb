# frozen_string_literal: false

# ./lib/displayable.rb
module Displayable
  def welcome_msg
    puts %(Connect 4: a classic game! Let's play!!!)
  end

  def rules_msg
    puts %(\nIn case you don't know the rules:)
    puts %(The goal is to get 4 of your tokens in a row, either horizontally, vertically, or diagonally)
    puts %(The first player to get 4 in a row wins!)
    puts %(You can only place tokens at the bottom of the board or on top of a placed token)
  end

  def new_player_msg
    print %(\nPlayer username: )
  end

  def display_grid(grid)
    puts
    43.times do |n|
      next if n.zero?

      digit_print(grid, n)
    end
  end

  def digit_print(grid, num)
    if (num % 7).zero?
      print %( #{grid[num]} |\n)
    elsif num % 7 == 1
      print %(| #{grid[num]} |)
    else
      print %( #{grid[num]} |)
    end
  end

  def turn_msg(name)
    puts %(\nIt's #{name}'s turn)
  end

  def grid_position_msg
    print %(Place token at: )
  end

  def error_msg
    puts %(\nInvalid option, try again)
  end

  def replay_msg
    print %(\nWould you like to play again? (y/n): )
  end

  def another_round_msg
    puts %(\nAnother round? Let's go!!!)
  end

  def winner_msg(name)
    puts %(\n#{name} wins!!!)
  end

  def game_draw_msg
    puts %(\nNeither player got 4 in a row, it's a draw)
  end

  def goodbye_msg
    puts %(\nThanks for playing, till next time!)
  end
end
