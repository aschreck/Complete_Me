require_relative "./test_helper"
require './lib/node'

class NodeTest < Minitest::Test

  def test_it_exists
    node = Node.new

    assert_instance_of Node, node
  end

  def test_it_initializes_with_empty_child_node_hash
    node = Node.new

    assert node.children.empty?
    refute node.has_children?
  end

  def test_initializes_with_flag_set_to_false
    node = Node.new

    refute node.flagged
  end

  def test_node_knows_children
    node = Node.new
    node.children["a"] = 'ardvark'

    assert node.has_children?
    refute node.children.empty?
  end
end
