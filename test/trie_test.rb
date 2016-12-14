require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/trie.rb'
require './lib/load.rb'

class TrieTest < Minitest::Test
  def test_trie_has_a_root
    trie = Trie.new
    assert trie.root
  end

  def test_trie_formats_words_into_letters
    trie = Trie.new
    assert_equal ["w", "o", "r", "d"], trie.format_word("word")
  end

  def test_trie_inserts_one_word
    trie = Trie.new
    assert trie.insert("word")
    assert_equal 1, trie.count
  end

  def test_trie_inserts_multiple_words
    trie = Trie.new
    trie.insert("word")
    trie.insert("dogs")
    trie.insert("witches")
    trie.insert("wolf")
    trie.insert("dogecoin")

    assert_equal 5, trie.count
  end

  def test_leaf_node_returns_full_word
    trie = Trie.new
    trie.insert("word")
    last_node = trie.root.links["w"].links["o"].links["r"].links["d"]

    assert_equal "word", last_node.total_word
  end

  def test_can_populate_dictionary_from_load
    skip
    trie = Trie.new
    loader = Load.new
    words = loader.format_dictionary('/usr/share/dict/words')
    trie.populate(words)

    assert_equal 235886, trie.count
  end

  def test_find_parent_returns_parent_node
    trie = Trie.new
    trie.insert("pen")
    trie.insert("pin")
    trie.insert("pizza")
    parent_node = trie.root.links["p"].links["i"].links.values
    sub_string_letters = ["p", "i"]

    assert_equal parent_node, trie.find_parent(sub_string_letters)
  end

  def test_suggest_returns_array_of_suggestions
    trie = Trie.new
    trie.insert("pen")
    trie.insert("pin")
    trie.insert("pizza")
    suggestions = ["pin", "pizza"]

    assert_equal suggestions, trie.suggest("pi")
  end

  def test_suggset_returns_a_different_array_of_suggestions
    trie = Trie.new
    words = ["cat", "concatenate", "cars", "car"]
    trie.populate(words)
    suggestions = ["cat", "car", "cars"]

    assert_equal suggestions, trie.suggest("ca")
  end

  def test_trie_suggests_from_dictionary
    skip
    trie = Trie.new
    loader = Load.new
    words = loader.format_dictionary('/usr/share/dict/words')
    trie.populate(words)

    assert_equal 235886, trie.count
    assert_equal ["doggerel", "doggereler", "doggerelism", "doggerelist", "doggerelize", "doggerelizer"], trie.suggest("doggerel").sort
  end

  def test_node_marked_as_suggested_from_suggest_method
    trie = Trie.new
    trie.insert("doge")
    trie.suggest("do")
    trie.suggest("do")
    trie.suggest("d")
    trie.suggest("dog")
    last_node = trie.root.links["d"].links["o"].links["g"].links["e"]

    assert_equal 4, last_node.times_suggested
  end

  def test_different_node_marked_as_suggested
    trie = Trie.new
    trie.insert("wiz")
    trie.suggest("wi")
    trie.suggest("wi")
    last_node = trie.root.links["w"].links["i"].links["z"]

    assert_equal 2, last_node.times_suggested
  end

  def test_node_marked_as_selected_from_select_method
    trie = Trie.new
    trie.insert("doge")
    trie.insert("dogecoin")
    trie.select("do", "dogecoin")

    assert_equal ["dogecoin", "doge"], trie.suggest("do")
  end

end
