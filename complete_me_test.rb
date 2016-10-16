gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :trie

  def setup
    @trie = Trie.new
  end

  def test_class_exists
    skip
  end

  def test_insert_blank_item
    skip
  end

  def test_insert_one_item
    skip
  end

end
