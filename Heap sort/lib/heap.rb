class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |a, b| a <=> b }
  end

  def count
    @store.length
  end

  def extract #switch > pop > sort
    return @store.pop if count <= 1

    @store[0], @store[-1] = @store[-1], @store[0]
    popped = @store.pop
    self.class.heapify_down(@store, 0, &prc)

    popped
  end

  def peek
    @store[0]
  end

  def push(val) #sort as you add
    @store.push(val)
    self.class.heapify_up(@store, count - 1, count, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    children = []
    (1..2).each do |num|
      child = ((parent_index * 2) + num)
      children << child if child < len
    end
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index <= 0
    ((child_index - 1) / 2)
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    children = child_indices(len, parent_idx)
    parent = array[parent_idx]

    return array if children.none? { |idx| prc.call(array[idx], parent) != 1}

    swap = 0
    if children.length == 1 || prc.call(array[children[0]], array[children[1]]) == -1
      swap = children[0]
    else
      swap = children[1]
    end

    array[parent_idx], array[swap] = array[swap], parent
    heapify_down(array, swap, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx <= 0
    prc ||= Proc.new { |a, b| a <=> b }

    parent = parent_index(child_idx)

    if prc.call(array[child_idx], array[parent]) == -1
      array[child_idx], array[parent] = array[parent], array[child_idx]
      heapify_up(array, parent, len, &prc)
    end

    array
  end
end
