require_relative '../test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/linked_list'
require_relative '../lib/node'

class LinkedListTest < Minitest::Test

  def test_it_has_a_head
    list = LinkedList.new
    assert_nil list.head
  end

  def test_append_returns_a_node
    list = LinkedList.new
    node = list.append("West", {"pounds of food" => 200})
    assert_instance_of Node, node
    assert_equal "West", node.surname
    assert_nil node.next_node
  end

  def test_it_has_a_count_of_nodes
    list = LinkedList.new
    assert_equal 0, list.count
    list.append("West", {"pounds of food" => 200})
    assert_equal 1, list.count
    list.append("Hardy", {"pounds of food" => 200})
    assert_equal 2, list.count
  end

  def test_it_can_print_name_of_node
    list = LinkedList.new
    list.append("West", {"pounds of food" => 200})
    assert_equal "The West family", list.to_string
    list.append("Hardy", {"pounds of food" => 200})
    assert_equal "The West family, followed by the Hardy family", list.to_string

  end

  def test_can_append_multiple_nodes
    list = LinkedList.new
    node1 = list.append("Rhodes", {"pounds of food" => 200})
    assert_equal node1, list.head
    assert_nil list.head.next_node
    node2 = list.append('Hardy', {"pounds of food" => 200})
    assert_equal node2, list.head.next_node
  end

  def test_can_prepend_node
    list = LinkedList.new
    node1 = list.append("Brooks", {"pounds of food" => 200})
    node2 = list.append("Henderson", {"pounds of food" => 200})
    node0 = list.prepend("McKinney", {"pounds of food" => 200})
    assert_instance_of Node, node0
    assert_equal node0, list.head
    assert_equal node1, list.head.next_node
    assert_equal node2, node1.next_node
  end

  def test_can_insert_node
    list = LinkedList.new
    node1 = list.append("Brooks", {"pounds of food" => 200})
    node2 = list.append("Henderson", {"pounds of food" => 200})
    node3 = list.insert(1, "Lawson", {"pounds of food" => 200})
    assert_equal node1, list.head
    assert_equal node3, list.head.next_node
    assert_equal node2, node3.next_node
  end

  def test_can_find_elements
    list = LinkedList.new
    list.append("Brooks", {"pounds of food" => 200})
    list.append("Henderson", {"pounds of food" => 200})
    list.append("Lawson", {"pounds of food" => 200})
    list.append("Chapman", {"pounds of food" => 200})
    assert_equal "The Henderson family", list.find(1,1)
    assert_equal "The Lawson family, followed by the Chapman family", list.find(2,2)
    assert_equal "The Lawson family, followed by the Chapman family", list.find(2,3)
  end

  def test_includes
    list = LinkedList.new
    list.append("Brooks", {"pounds of food" => 200})
    list.append("Henderson", {"pounds of food" => 200})
    assert_equal true, list.includes?("Brooks")
    assert_equal false, list.includes?("Bob")
  end

  def test_pop
    list = LinkedList.new
    list.append("Brooks", {"pounds of food" => 200})
    node2 = list.append("Henderson", {"pounds of food" => 200})
    node3 = list.append("Chapman", {"pounds of food" => 200})
    assert_equal node3, list.pop
    assert_equal node2, list.pop
    assert_nil list.head.next_node
  end
end
