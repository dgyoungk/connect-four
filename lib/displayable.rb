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

  # def grid_information_msg
  #   puts %(\nEach spot in the board can be indicated with numbers, from 1 to 42)
  #   puts %(1 is the top-left corner, and 42 is the bottom-right corner)
  # end

  def new_player_msg
    print %(\nPlayer username: )
  end

  def display_grid(grid)
    puts
    43.times do |n|
      next if n == 0
      if n <= 9
        single_digit_print(grid, n)
      else
        double_digit_print(grid, n)
      end
    end
  end

  def single_digit_print(grid, num)
    if (num) % 7 == 0
      print %( 0#{grid[num]} |\n)
    elsif (num) % 7 == 1
      print "|" + %( 0#{grid[num]} |)
    else
      print %( 0#{grid[num]} |)
    end
  end

  def double_digit_print(grid, num)
    if (num) % 7 == 0
      print %( #{grid[num]} |\n)
    elsif (num) % 7 == 1
      print "|" + %( #{grid[num]} |)
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
    puts %(Invalid option, try again)
  end
  # TODO: implement rest of the in-game messages
  def replay_msg
    print %(Would you like to play again? (y/n): )
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
