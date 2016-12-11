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




end
