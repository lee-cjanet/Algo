
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)

  end

  def to_s

  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

  end
end

class LinkedList
  include Enumerable
  def initialize

  end

  def [](i)

  end

  def first

  end

  def last

  end

  def empty?

  end

  def get(key)

  end

  def include?(key)

  end

  def append(key, val)

  end

  def update(key, val)

  end

  def remove(key)

  end

  def each(&prc)

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s

  end
end
