require 'pry'

class Load
  def load_dictionary(filename)
    dictionary = File.read(filename)
    # dictionary = opened.read
  end

  def format_dictionary(filename = './lib/test.txt')
    dictionary = load_dictionary(filename)
    words = dictionary.split("\n")
  end
end