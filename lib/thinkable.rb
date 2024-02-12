require_relative 'displayable'

# this module will house all helper and logic-related methods
# such as user input, condition-checking, etc...
module Thinkable
  include Displayable

  def get_marker_choices
    return { "black" => "\u25EF", 'white' => "\u25C9" }
  end

  def verify_choice(input)
    return input == 'black' || input == 'white'
  end

  # this will return the indicated choice back to the Game class
  # then Game class will call designate_marker on the player object
  def choose_marker
    marker_msg
    choice = gets.chomp.downcase
    until verify_choice(choice)
      error_msg
      marker_msg
      choice = gets.chomp.downcase
    end
    choice
  end
end
