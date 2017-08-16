require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)

    @store[index]
  end

  # O(1)
  def []=(index, val)
    @store[index] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    popped = @store[@length - 1]
    @length -=1
    @store = @store[0..@length]
    popped
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
      @store[@length] = val
      @length += 1
      @store
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    @length -=1
    shifted = @store[0]
    @store = @store[1..-1]
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    (0...@length).each do |idx|
      @store[@length - idx] = @store[@length - idx - 1]
    end

    @store[0] = val
    @length+=1
    @store
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    # raise "index out of bounds" if @length < index + 1
    raise "index out of bounds" if @length < index + 1
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity += 8
    temp = StaticArray.new(@capacity)
    @length.times do |idx|
      temp[idx] = @store[idx]
    end

    @store = temp
  end
end
