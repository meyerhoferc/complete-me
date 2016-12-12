require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/load.rb'

class LoadTest < Minitest::Test
  def test_loads_dictionary
    loader = Load.new
    assert loader.load_dictionary('./lib/test.txt')
  end

  def test_formats_dictionary_into_array_of_words
    loader = Load.new
    loader.format_dictionary
    assert_equal Array, loader.format_dictionary.class
  end
end
