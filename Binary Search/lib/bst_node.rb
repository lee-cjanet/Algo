class BSTNode

  attr_reader :depth
  attr_accessor :value, :left, :right, :parent

  def initialize(value, parent=nil)
    @value = value
    @left = nil
    @right = nil
    @parent = parent
    @depth = 1
  end
end
