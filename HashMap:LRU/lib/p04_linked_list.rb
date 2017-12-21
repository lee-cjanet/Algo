
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @prev = nil
    @next = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next if @next
    @next.prev = @prev if @prev
    self.prev = nil
    self.next = nil
    self
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    # node = @head.next
    # idx = 0
    # until node.next == nil
    #   return node if i == idx
    #   node = node.next
    #   idx+=1
    # end
    each_with_index { |node, idx| return node if i == idx }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    # node = @head
    # until node.next == nil
    #   return node.val if node.key == key
    #   node = node.next
    # end
    each {|node| return node.val if node.key == key}
    nil
  end

  def include?(key)
    # node = @head
    # until node.next == nil
    #   return true if node.key == key
    #   node = node.next
    # end
    any? {|node| node.key == key}
  end

  def append(key, val)
    link = Link.new(key, val)
    link.prev = @tail.prev
    link.next = @tail
    @tail.prev = link
    link.prev.next = link
    link
  end

  def update(key, val)
    # node = @head
    # until node.next == nil
    #   if node.key == key
    #     node.val = val
    #     return node
    #   end
    #   node = node.next
    # end

    each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end

    nil
  end

  def remove(key)
    # node = @head
    # until node.next == nil
    #   if node.key == key
    #     node.remove
    #     return nil
    #   end
    #   node = node.next
    # end
    each do |node|
      if node.key == key
        node.remove
        return nil #must return nil b/c no more .next on current node
      end
    end
    nil
  end

  def each(&prc)
    node = @head.next
    until node.next == nil
      prc.call(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s

  end
end
