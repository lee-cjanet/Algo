require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(@num_buckets) {Array.new}
    @count = 0
  end

  def insert(key)
    self[key.hash] << key
    @count+=1
    resize! if @count >= num_buckets
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    self[key.hash].delete(key)
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
