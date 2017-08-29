class Node

  attr_accessor :children, :flagged, :weight, :prefix_weights

  def initialize(char = "")
    @children = {}
    @flagged = false
    @weight = 0
    @prefix_weights = {}
    #do we need to save char in the argument as an instance variable?
  end

  def has_children?
    true if @children == {}
  end

end
