require_relative 'test_helper.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/node.rb'


class NodeTest < Minitest::Test

  def test_node_exists
    node = Node.new
    assert_equal Node, node.class
  end

  def test_links_returns_hash
    node = Node.new
    assert_equal Hash, node.links.class
  end

  def test_node_links_to_other_node
    node_1 = Node.new
    node_2 = Node.new
    node_1.links = {"a" => node_2}

    assert_equal({"a" => node_2}, node_1.links)
  end

  def test_key_returns_node
    node_1 = Node.new
    node_2 = Node.new
    node_1.links = {"a" => node_2}

    assert node_1.links.has_key?("a")
  end

  def test_links_returns_all_children
    node_1 = Node.new
    node_2 = Node.new
    node_3 = Node.new
    node_1.links["a"] = node_2
    node_1.links["b"] = node_3

    assert_equal({"a" => node_2, "b" => node_3}, node_1.links)
  end

  def test_links_knows_it_does_not_have_a_child
    node_1 = Node.new
    node_2 = Node.new
    node_3 = Node.new
    node_4 = Node.new
    node_5 = Node.new
    node_6 = Node.new
    node_1.links["a"] = node_2
    node_1.links["b"] = node_3
    node_2.links["c"] = node_4
    node_3.links["i"] = node_6
    node_4.links["t"] = node_5

    assert_equal({}, node_1.links["a"].links["c"].links["t"].links)
  end

  def test_node_can_increase_times_selected_for_substring
    node = Node.new
    node.total_word = "pizza"
    node.word_suggested("pi")
    node.word_suggested("pi")
    node.word_suggested("pi")
    node.word_selected("pi")
    node.word_selected("pi")

    assert_equal 3, node.substring_and_weight["pi"][0]
    assert_equal 2, node.substring_and_weight["pi"][1]
  end

end
