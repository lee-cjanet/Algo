require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)

  end

  def include?(key)

  end

  def set(key, val) #[]=      : set alias

  end

  def get(key) #[]   :  get alias

  end

  def delete(key)

  end

  def each(&prc)

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

  end

  def resize!

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`

  end
end
