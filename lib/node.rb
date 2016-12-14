
class Node
  attr_accessor :links,
                :total_word,
                :substring_and_weight

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


  def add_substring_rank(sub_string, suggested, selected = 0)
    if @substring_and_weight.has_key?(sub_string)
      @substring_and_weight[sub_string] #will be different for select and suggest
      # should make different methods to change these?
      # could store incomcing value, delete, add to it, and replace
    else
      @substring_and_weight[sub_string] = Array.new(2)
      @substring_and_weight[sub_string] = [suggested, selected]
    end
  end

  def times_suggested(sub_string)
    @substring_and_weight[sub_string][0]
  end

  def times_selected(sub_string)
    @substring_and_weight[sub_string][1]
  end

  def weight(sub_string)
    values = @substring_and_weight[sub_string].values
    (values[1]/values[0]).to_f
  end

end
