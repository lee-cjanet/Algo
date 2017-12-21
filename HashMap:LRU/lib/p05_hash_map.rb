require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) {LinkedList.new}
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val) #[]=      : set alias
    # p bucket(key)
    if include?(key)
      bucket(key).update(key,val)
    else
      bucket(key).append(key,val)
      @count+=1
      resize! if @count >= num_buckets
    end
  end

  def get(key) #[]   :  get alias
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -=1
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end
    end
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
    @num_buckets
  end

  def resize!
    old_list = @store
    @num_buckets*=2
    @count = 0

    @store = Array.new(num_buckets) {LinkedList.new}

    old_list.each do |list|
      list.each do |link|
        set(link.key, link.val)
      end
    end

    old_list = nil
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
