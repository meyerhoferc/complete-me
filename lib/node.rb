
class Node
  attr_accessor :links,
                :total_word,
                :substring_and_weight

  def initialize
    @links = Hash.new
    @end_of_word = false
    @total_word = ""
    @substring_and_weight = Hash.new
  end

  def end_of_word?
    @end_of_word
  end

  def mark_as_end
    @end_of_word = true
  end

  def word_selected(sub_string)
    if @substring_and_weight.has_key?(sub_string)
      values = @substring_and_weight[sub_string]
      values[1] = values[1] + 1
    else
      @substring_and_weight[sub_string] = [0, 0]
      word_selected(sub_string)
    end
  end

  def word_suggested(sub_string)
    if @substring_and_weight.has_key?(sub_string)
      values = @substring_and_weight[sub_string]
      values[0] = values[0] + 1
    else
      @substring_and_weight[sub_string] = [0, 0]
      word_suggested(sub_string)
    end
  end

  def times_selected(sub_string)
    if @substring_and_weight.has_key?(sub_string)
      @substring_and_weight[sub_string][1]
    else
      0
    end
  end

end
