class Node

  attr_accessor :children, :flagged, :weight

  def initialize(char = "")
    @children = {}
    @flagged = false
    @weight = 0
    #do we need to save char in the argument as an instance variable?
  end

  def has_children?
    true if @children == {}
  end


end
