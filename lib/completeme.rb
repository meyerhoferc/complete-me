require 'pry'
require './lib/node.rb'
require './lib/load.rb'

class CompleteMe

  attr_accessor :root, :count, :sub_string_key
  dictionary = File.read("/usr/share/dict/words")

  def initialize
    @root = Node.new
    @count = 0
    @suggestions = {}
    @suggested_words = []
    @sub_string_key = ""
  end

  def format_word(word)
    word.chars
  end

  def insert(word)
    letters = format_word(word)
    current_node = @root
    total_word = ""
    add_word(letters, current_node, total_word)
    @count += 1
  end

  def add_word(letters, current_node, total_word)
    unless letters.empty?
      to_insert = letters.shift
      total_word += to_insert
      if current_node.links.has_key?(to_insert)
        add_word(letters, current_node.links[to_insert], total_word)
      else
        current_node.links[to_insert] = Node.new
        add_word(letters, current_node.links[to_insert], total_word)
      end
    else
      current_node.mark_as_end
      current_node.total_word = total_word
    end
  end

  # def populate(words)
  #   words.each { |word| insert(word) }
  # end

  def populate(new_line_separated_words)
    words = new_line_separated_words.split("\n")
    words.each { |word| insert(word) }
  end

  def suggest(sub_string)
    @sub_string_key = sub_string
    letters = format_word(sub_string)
    find_all_children(find_parent(letters))
    suggested_words(sub_string)
    @suggested_words
  end

  def find_parent(letters, current_node = @root)
    if letters.empty?
      if current_node.end_of_word?
        @suggestions[current_node] = current_node.total_word
        current_node.word_suggested(@sub_string_key)
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
        @suggestions[node] = node.total_word
        node.word_suggested(@sub_string_key)
      end
      if node.links.count > 0
        find_all_children(node.links.values)
      end
    end
  end

  def suggested_words(sub_string)
    sorted_suggestions = @suggestions.sort_by do |node, word|
      node.weight(sub_string)
    end
    @suggested_words = sorted_suggestions.map do |pair|
      pair[1]
    end
    @suggested_words = @suggested_words.reverse
  end

  def select(substring, selection)
    suggest(substring)
    @suggestions.key(selection).word_selected(substring)
  end

end