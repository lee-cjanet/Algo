class MaxIntSet
  #one big bucket
  #an array of true and falses
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num) || @store[num] = true
  end

  def remove(num)
    @store[num]=false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
    raise "Out of bounds" if num > @max || num < 0
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num % num_buckets] << num
  end

  def remove(num)
    self[num % num_buckets].delete(num)
  end

  def include?(num)
    self[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    resize! if @num_buckets == @count
    self[num % num_buckets] << num
    @count+=1
  end

  def remove(num)
    self[num % num_buckets].delete(num)
    @count-=1
  end

  def include?(num)
    self[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets.times {@store << []}
    @store.each do |bucket|
      bucket.each do |num|
        @store[num % num_buckets] << bucket.delete(num)
      end
    end
  end
end
