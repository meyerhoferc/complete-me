require 'pry'
require './lib/node.rb'

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
    letters.each do |letter|
      set_letter(letter)
    end
    @count += 1
  end

end
