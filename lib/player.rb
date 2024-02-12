require_relative 'thinkable'

class Player
  include Thinkable

  attr_accessor :mark, :name

  def initialize(name, mark = '')
    self.name = name
    self.mark = mark
  end

  def designate_marker(choice)
    avail_markers = get_marker_choices
    self.mark = avail_markers[choice]
  end
end
