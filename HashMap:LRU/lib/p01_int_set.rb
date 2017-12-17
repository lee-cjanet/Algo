class MaxIntSet
  #one big bucket
  #an array of true and falses
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
    @store.dup
  end

  def remove(num)
    validate!(num)
    @store[num] = false
    @store.dup
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max
  end

  def validate!(num)
    raise 'please input a number between 0 and #{@max}, inclusive' unless is_valid?(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)

  end

  def insert(num)

  end

  def remove(num)

  end

  def include?(num)

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`

  end

  def num_buckets

  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)

  end

  def insert(num)

  end

  def remove(num)

  end

  def include?(num)

  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`

  end

  def num_buckets

  end

  def resize!

  end
end
