class Node

  attr_accessor :children, :flagged

  def initialize(char = "")
    @children = {}
    @flagged = false
  end

  def has_children?
    true if @children = {}
  end


end
