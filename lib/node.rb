class Node

  attr_accessor :children, :flagged, :weight, :prefix_selected

  def initialize(char = "")
    @children = {}
    @flagged = false
    @weight = 0
    @prefix_selected = false
    #do we need to save char in the argument as an instance variable?
  end

  def has_children?
    true if @children == {}
  end

  def prefix_selected?
    @prefix_selected
  end


end
