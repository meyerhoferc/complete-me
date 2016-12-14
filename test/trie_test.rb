require_relative 'test_helper.rb'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/complete_me.rb'
# require './lib/load.rb'


class CompleteMeTest < Minitest::Test
  def test_cm_has_a_root
    cm = CompleteMe.new
    assert cm.root
  end

  def test_formats_words_into_letters
    cm = CompleteMe.new
    assert_equal ["w", "o", "r", "d"], cm.format_word("word")
  end

  def test_trie_inserts_one_word
    cm = CompleteMe.new
    assert cm.insert("word")
    assert_equal 1, cm.count
  end

  def test_trie_inserts_multiple_words
    cm = CompleteMe.new
    cm.insert("word")
    cm.insert("dogs")
    cm.insert("witches")
    cm.insert("wolf")
    cm.insert("dogecoin")

    assert_equal 5, cm.count
  end

  def test_inserts_multiple_words
    cm = CompleteMe.new
    cm.populate("pizza\ndog\ncat")
    assert_equal 3, cm.count
  end

  def test_leaf_node_returns_full_word
    cm = CompleteMe.new
    cm.insert("word")
    last_node = cm.root.links["w"].links["o"].links["r"].links["d"]

    assert_equal "word", last_node.total_word
  end

  def test_can_populate_dictionary_from_load
    cm = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    cm.populate(dictionary)

    assert_equal 235886, cm.count
  end

  def test_find_parent_returns_parent_node
    cm = CompleteMe.new
    cm.insert("pen")
    cm.insert("pin")
    cm.insert("pizza")
    parent_node = cm.root.links["p"].links["i"].links.values
    sub_string_letters = ["p", "i"]

    assert_equal parent_node, cm.find_parent(sub_string_letters)
  end

  def test_suggest_returns_array_of_suggestions
    cm = CompleteMe.new
    cm.insert("pen")
    cm.insert("pin")
    cm.insert("pizza")
    suggestions = ["pin", "pizza"]

    assert_equal suggestions, cm.suggest("pi").sort
  end

  def test_suggset_returns_a_different_array_of_suggestions
    cm = CompleteMe.new
    words = "cat\nconcatenate\ncars\ncar"
    cm.populate(words)
    suggestions = ["car", "cars", "cat"]

    assert_equal suggestions, cm.suggest("ca").sort
  end

  def test_suggests_from_dictionary
    cm = CompleteMe.new
    dictionary = File.read("/usr/share/dict/words")
    cm.populate(dictionary)

    assert_equal 235886, cm.count
    assert_equal ["doggerel", "doggereler", "doggerelism", "doggerelist", "doggerelize", "doggerelizer"], cm.suggest("doggerel").sort
  end

  def test_node_marked_as_suggested_from_suggest_method
    cm = CompleteMe.new
    cm.insert("doge")
    cm.suggest("do")
    cm.suggest("do")
    cm.suggest("d")
    cm.suggest("dog")
    last_node = cm.root.links["d"].links["o"].links["g"].links["e"]

    assert_equal 2, last_node.times_suggested("do")
  end

  def test_different_node_marked_as_suggested
    cm = CompleteMe.new
    cm.insert("wiz")
    cm.suggest("wi")
    cm.suggest("wi")
    last_node = cm.root.links["w"].links["i"].links["z"]

    assert_equal 2, last_node.times_suggested("wi")
  end

  def test_selected_word_returns_first_when_suggested
    cm = CompleteMe.new
    cm.insert("doge")
    cm.insert("dogecoin")
    cm.select("do", "dogecoin")

    assert_equal ["dogecoin", "doge"], cm.suggest("do")
  end

end
