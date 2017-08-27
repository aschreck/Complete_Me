class Node

  attr_accessor :children, :flagged

  def initialize(char = "")
    @children = {}
    @flagged = false
    #do we need to save char in the argument as an instance variable?
  end

  def has_children?
    true if @children == {}
  end


end
