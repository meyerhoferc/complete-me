require 'pry'
require './lib/node.rb'
require './lib/load.rb'

class Trie
  attr_accessor :root, :count, :sub_string_key
  def initialize
    @root = Node.new
    @count = 0
    @suggestions = []
    @sub_string_key = ""
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
    @sub_string_key = sub_string
    letters = format_word(sub_string)
    find_all_children(find_parent(letters))
    @suggestions # change order using maxby or enum
  end

  def find_parent(letters, current_node = @root)
    if letters.empty?
      if current_node.end_of_word?
        @suggestions << current_node.total_word
        current_node.add_substring_rank(@sub_string_key, 1)
      end
      current_node.links.values
    else
      letter = letters.shift
      find_parent(letters, current_node.links[letter])
    end
  end

  def find_all_children(nodes)
    nodes.each do |node|
      if node.end_of_word?
        @suggestions << node.total_word
        node.add_substring_rank(@sub_string_key, 1)
      end
      if node.links.count > 0
        find_all_children(node.links.values)
      end
    end
  end

  def select(substring, selection)
    #identity selection's end node
    # mark as selected + 1 for this substring in hash
    # calls suggest which will return weighted order suggestions

    # suggest(substring)
    @suggestions
  end

end
