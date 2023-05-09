require_relative "binary_trees.rb"
require_relative "node.rb"

array = Array.new(15) { rand(1..100) }

tree = Tree.new(array)
tree.pretty_print
puts tree.balanced? ? "The tree is balanced" : "The tree is not balanced"
puts "Level order traversal: "
puts tree.level_order
puts "pre order traversal: "
puts tree.preorder
puts "post order traversal: "
puts tree.postorder
puts "in order traversal: "
puts tree.inorder

15.times do
  n = rand(100..300)
  tree.insert(n)
  puts "#{n} has been inserted in the tree"
end

tree.pretty_print
puts tree.balanced? ? "The tree is balanced" : "The tree is not balanced"
puts "Balancing the tree: "
tree.rebalance
tree.pretty_print
puts tree.balanced? ? "The tree is balanced" : "The tree is not balanced"
puts "Level order traversal: "
puts tree.level_order
puts "pre order traversal: "
puts tree.preorder
puts "post order traversal: "
puts tree.postorder
puts "in order traversal: "
puts tree.inorder
