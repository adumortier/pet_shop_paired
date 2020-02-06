require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'

class NodeTest < Minitest::Test

  def test_it_has_a_surname
    node = Node.new("Frank", {"pounds of food" => 200})
    assert_equal "Frank", node.surname
  end

  def test_it_is_initialized_without_next_node
    node = Node.new("Frank", {"pounds of food" => 200})
    assert_nil node.next_node
  end

end
