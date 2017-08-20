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

    if value >= self ?
      if self.right ?
        self.right.insert(value)
      else
        self.right = BSTNode.new(value, self)
      end
    else
      if self.left ?
        self.left.insert(value)
      else
        self.left = BSTNode.new(value, self)
      end
    end
  end

  def find(value, tree_node = @root)
  end

  def delete(value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

end
