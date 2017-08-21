require_relative 'bst_node'

# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree

  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value)
    # returns first value
    return @root = BSTNode.new(value) unless @root

    insert_node(value, @root)
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if value == tree_node.value

    if tree_node.value > value
      return find(value, tree_node.left)
    else
      return find(value, tree_node.right)
    end

  end

  def delete(value)
    return nil unless find(value)
    node = find(value) #node to delete

    case children(node)
    when 0
      if node == @root
        @root = nil
      elsif node.parent.left == node
        node.parent.left = nil
      else
        node.parent.right = nil
      end
      node.parent = nil
    when 1
      # change r.parent.left or right
      # change r.left or right
      if node.left
        replacement = maximum(node.left)
      else
        replacement = maximum(node.right)
      end

      if replacement.left
        replacement.parent.right = replacement.left
        replacement.left.parent = replacement.parent
      else
        replacement.parent.right = nil
      end

      # change r properties to reflect node's
      if node.left
        node.left.parent = replacement
      end

      if node.right
        node.right.parent = replacement
      end

      replacement.parent = node.parent
      replacement.left = node.left
      replacement.right = node.right

    when 2

    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node unless tree_node.right
    max = tree_node

    while max.right
      max = max.right
    end

    max
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil? || (tree_node.left.nil? && tree_node.right.nil?)
    1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true unless tree_node
    return false if (depth(tree_node.left) - depth(tree_node.right)).abs > 1
    [is_balanced?(tree_node.left), is_balanced?(tree_node.right)].all?
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  # optional helper methods go here:

  def insert_node(value, parent)
    if value >= parent.value
      if parent.right
        insert_node(value, parent.right)
      else
        parent.right = BSTNode.new(value, parent)
      end
    else
      if parent.left
        insert_node(value, parent.left)
      else
        parent.left = BSTNode.new(value, parent)
      end
    end
  end

  def children(node)
    children = 0

    children += 1 if node.left
    children += 1 if node.right

    children
  end

  # def destroy_parent(node)
  #   if node.parent.left == node
  #     node.parent.left = nil
  #     # node.parent = nil
  #   else
  #     node.parent.right == nil
  #     # node.parent = nil
  #   end
  # end

  def replaceable?(node, r)
    node.value <= r.value &&  r.value >= node.left.value && r.value <= node.right.value
  end

  def replace_parent(node)
  end

  def replace_child(node)
  end

end
