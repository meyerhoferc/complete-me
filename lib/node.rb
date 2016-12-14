
class Node
  attr_accessor :links, :total_word, :times_selected, :times_suggested

  def initialize
    @links = Hash.new
    @end_of_word = false
    @total_word = ""
    @times_selected = 0
    @times_suggested = 0
    @weight = 0
  end

  def end_of_word?
    @end_of_word
  end

  def mark_as_end
    @end_of_word = true
  end

  def selected
    @times_selected += 1
  end

  def suggested
    @times_suggested += 1
  end

  def weight
    @weight = @times_selected / @times_suggested
  end

  # def set_letter(letter, current_node)
  #   if current_node.links.has_key?(letter)
  #     current_node = current_node.links[letter]
  #     return letter
  #   else
  #     current_node.links[letter] = Node.new
  #   end
  #   return current_node.links
  # end

end
