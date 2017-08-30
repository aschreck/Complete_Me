class Node

  attr_accessor :children, :flagged, :prefix_weights

  def initialize
    @children = {}
    @flagged = false
    @prefix_weights = {}
  end

  def has_children?
    false if @children.empty?
  end

end
