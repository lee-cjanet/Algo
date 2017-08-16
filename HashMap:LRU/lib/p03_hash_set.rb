require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(key)
    resize! if @num_buckets == @count
    value = key.hash
    self[value % num_buckets] << value
    @count+=1
  end

  def include?(key)
    value = key.hash
    self[value % num_buckets].include?(value)
  end

  def remove(key)
    value = key.hash
    self[value % num_buckets].delete(value)
    @count -= 1
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
