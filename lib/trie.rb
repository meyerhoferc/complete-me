require 'pry'
require './lib/node.rb'
require './lib/load.rb'

class Trie
  attr_accessor :root, :count
  def initialize
    @root = Node.new
    @count = 0
    @suggestions = []
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
    letters = format_word(sub_string)
    find_all_children(find_parent(letters))
    @suggestions
  end

  def find_parent(letters, current_node = @root)
    if letters.empty?
      if current_node.end_of_word?
        @suggestions << current_node.total_word
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
      end
      if node.links.count > 0
        find_all_children(node.links.values)
      end
    end
  end



  # def find_all_children(current_node)
  #   all_nodes = current_node.links.values
  #   all_nodes.find_all do |node|
  #     if node.end_of_word?
  #       @suggestions << node.total_word
  #     # else
  #     #   find_all_children(current_node.links)
  #     end
  #     if node.links.count > 0
  #       check_number_of_links(node)
  #     end
  #   end
  # end

  # def check_number_of_links(current_node)
  #   if current_node.links.count == 1 && current_node.end_of_word? == false
  #     find_all_children(next_node(current_node))
  #   else
  #     find_all_children(current_node)
  #   end
  # end

  # def next_node(current_node)
  #   current_node.links.values.first
  # end

end
