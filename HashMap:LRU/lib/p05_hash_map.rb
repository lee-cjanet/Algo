require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val) #[]=      : set alias
    if @store[bucket(key)].include?(key)
      @store[bucket(key)].update(key, val)
    else
      @count+=1
      @store[bucket(key)].append(key, val)
    end
  end

  def get(key) #[]   :  get alias
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @count-=1
    @store[bucket(key)].remove(key)
  end

  def each(&prc)
    result = []
    @store.each do |linkedlist|
      linkedlist.each do |link|
        result << prc.call(link.key, link.val)
      end
    end
    result
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each { |link| set(link.key, link.val) }
    end
      end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
