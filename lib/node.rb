class Node
  attr_accessor :links

  def initialize
    @links = Hash.new
    @end_of_word = false
  end

  def end_of_word?
    @end_of_word
  end

  def mark_as_end
    @end_of_word = true
  end
end
