require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/trie.rb'

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

  def test_tree_recognizes_end_of_word
    skip
    trie = Trie.new
    trie.insert("word")
    assert_equal
  end

  def test_leaf_node_returns_full_word
    trie = Trie.new
    trie.insert("word")
    last_node = trie.root.links["w"].links["o"].links["r"].links["d"]
    assert_equal "word", last_node.total_word

  end




end
