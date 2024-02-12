module Displayable

  def welcome_msg
    puts %(Connect 4: a classic game! Let's play!!!)
  end

  def rules_msg
    puts %(\nIn case you don't know the rules:)
    puts %(The goal is to get 4 of your tokens in a row)
    puts %(Horizontally, vertically, or diagonally)
    puts %(The first player to get 4 in a row wins!)
  end

  def new_player_msg
    print %(Player username: )
  end

  def display_grid

  end

  def marker_msg
    print %(Choose a color for your token (black/white): )
  end

  def grid_position_msg
    print %(Place token at: )
  end

  def error_msg
    puts %(Invalid option, try again)
  end
end
