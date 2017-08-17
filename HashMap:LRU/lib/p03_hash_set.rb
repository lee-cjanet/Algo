require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    resize! if @num_buckets == @count
    self[key.hash % num_buckets] << key
    @count += 1
    key
  end

  def include?(key)
    self[key.hash % num_buckets].include?(key)
  end

  def remove(key)
    return nil unless include?(key)
    self[key.hash % num_buckets].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets.times {@store << []}
    @store.each do |bucket|
      bucket.each do |key|
        @store[key.hash % num_buckets] << bucket.delete(key)
      end
    end
  end
end
