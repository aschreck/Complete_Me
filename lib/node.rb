class Node

  attr_accessor :children, :flagged, :prefix_weights

  def initialize(char = "")
    @children = {}
    @flagged = false
    @weight = 0
    @prefix_weights = {}
  end

  def has_children?
    true if @children == {}
  end

end
