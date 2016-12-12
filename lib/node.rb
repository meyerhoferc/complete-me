
class Node
  attr_accessor :links, :total_word

  def initialize
    @links = Hash.new
    @end_of_word = false
    @total_word = ""
    # @current_node = nil
  end

  def end_of_word?
    @end_of_word
  end

  def mark_as_end
    @end_of_word = true
  end

  def set_letter(letter, current_node)
    if current_node.links.has_key?(letter)
      current_node = current_node.links[letter]
      return letter
    else
      current_node.links[letter] = Node.new
    end
    return current_node.links
  end

end
