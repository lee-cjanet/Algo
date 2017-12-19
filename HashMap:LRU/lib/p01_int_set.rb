class MaxIntSet
  #one big bucket
  #an array of true and falses
  # can only hold integers bwt 0 & max
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
    num.between?(0, @store.length)
  end

  def validate!(num)
    raise 'Out of bounds' unless is_valid?(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) {Array.new}
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num%num_buckets]
  end

  def num_buckets
    @num_buckets
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) {Array.new}
    @count = 0
  end

  def insert(num)
    unless include?(num)
      self[num] << num
      @count+=1
    end
    resize! if @count >= @num_buckets
  end

  def remove(num)
    @count-=1
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num%num_buckets]
  end

  def num_buckets
    @num_buckets
  end

  def resize!
    @num_buckets *=2

    new_store = Array.new(@num_buckets) {Array.new}

    @store.flatten.each do |num|
        new_store[num % num_buckets] << num
    end

    @store = new_store
  end
end
