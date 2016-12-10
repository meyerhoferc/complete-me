class Node
  attr_reader :letter
  attr_accessor :links

  def initialize(letter)
    @letter = letter
    @links = Array.new
  end

end
