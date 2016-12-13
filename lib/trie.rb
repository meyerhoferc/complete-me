require 'pry'
require './lib/node.rb'
require './lib/load.rb'

class Trie
  attr_accessor :root, :count
  def initialize
    @root = Node.new
    @count = 0
  end

  def format_word(word)
    word.chars
  end

  def insert(word)
    letters = format_word(word)
    current_node = @root
    total_word = ""
    add_word_to_tree(letters, current_node, total_word)
    @count += 1
  end

  def add_word_to_tree(letters, current_node, total_word)
    unless letters.empty?
      to_insert = letters.shift
      total_word += to_insert
      if current_node.links.has_key?(to_insert)
        add_word_to_tree(letters, current_node.links[to_insert], total_word)
      else
        current_node.links[to_insert] = Node.new
        add_word_to_tree(letters, current_node.links[to_insert], total_word)
      end
    else
      current_node.mark_as_end
      current_node.total_word = total_word
    end
  end

  def populate(words)
    words.each { |word| insert(word) }
  end

  def suggest(sub_string)
    current_node = @root
    letters = format_word(sub_string)
    find_parent(letters, current_node)
  end

  def find_parent(letters, current_node = @root)
    if letters.empty?
      current_node
    else
      letter = letters.shift
      find_parent(letters, current_node.links[letter])
    end
  end

end
