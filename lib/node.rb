
class Node
  attr_accessor :links,
                :total_word

  def initialize
    @links = Hash.new
    @end_of_word = false
    @total_word = ""
    # @times_selected = 0
    # @times_suggested = 0
    # @weight = 0
    @substring_and_weight = Hash.new
  end

  def end_of_word?
    @end_of_word
  end

  def mark_as_end
    @end_of_word = true
  end

  def selected(sub_string)
    values = @substring_and_weight[sub_string]
    values[1] = values[1] + 1
  end

  def suggested(sub_string)
    values = @substring_and_weight[sub_string]
    values[0] = values[0] + 1
  end

  def substring_and_weight(sub_string)
    @substring_and_weight[sub_string] = [0, 0]
  end

  def times_suggested(sub_string)
    @substring_and_weight[sub_string][0]
  end

  def times_selected(sub_string)
    @substring_and_weight[sub_string][1]
  end

  def weight(sub_string)
    values = @substring_and_weight[sub_string]
    (values[1]/values[0]).to_f
  end

end
