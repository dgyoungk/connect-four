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

  def grid_position_msg
    puts %(Each spot in the board can be indicated with numbers, from 1 to 42)
    puts %(1 is the top-left corner, and 42 is the bottom-right corner)
  end

  def new_player_msg
    print %(Player username: )
  end

  def display_grid(grid)
    42.times do |n|
      if (n + 1) % 7 == 0
        print %( #{grid[n + 1]} |\n)
      elsif (n + 1) % 7 == 1
        print "|" + %( #{grid[n + 1]} |)
      else
        print %( #{grid[n + 1]} |)
      end
    end
  end

  def turn_msg(player)
    puts %(It's #{player.name}'s turn)
  end

  def grid_position_msg
    print %(Place token at: )
  end

  def error_msg
    puts %(Invalid option, try again)
  end
  # TODO: implement rest of the in-game messages
end
