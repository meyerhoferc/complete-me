require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/node.rb'

class NodeTest < Minitest::Test

  attr_reader :node

  def setup
    @node = Node.new("a")
  end

  def test_node_exists
    assert node
  end

  def test_node_has_letter
    assert_equal "a", node.letter
  end

  def test_node_connects_to_other_node
    node_2 = Node.new("b")
    node.links = node_2
    assert_equal "b", node.links.letter
  end

  def test_node_connects_to_more_than_one
    node_2 = Node.new("b")
    node_3 = Node.new("c")
    node.links << node_2
    node.links << node_3
    assert_equal [node_2, node_3], node.links
  end

end
