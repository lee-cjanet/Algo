require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  return true if string.length < 2
  map = Hash.new(0)
  (0...string.length).each do |idx|
    map[string[idx]]+=1
  end

  odds = 0
  map.each do |k,v|
    odds += (v.odd? ? 1 : 0)
    return false if odds > 1
  end

  true
end

def palindrome_ll(list)
  first_half = []

  first_node = list.first
  second_node = list.first
  until second_node.next == nil
    first_half.unshift(first_node)
    first_node = first_node.next
    second_node = second_node.next.next
  end

  first_half.each do |node|
    return false unless node.info == second_node.info
    second_node = second_node.next
  end
  true
end

# ========================================
# You have two numbers represented by a LL, where each node contains a single digit. The digits are stored in reverse order, such that the 1's digit is at the head of the list. Write a function that adds the two numbers and returns the sum as a linked list.

def sum_lists(l1, l2)
  sum = LinkedList.new

  carry = 0
  node1 = l1.first
  node2 = l2.first

  until node1.next == nil || node2.next == nil
    carry = (node1.info + node2.info) / 10
    sum.append((node1.info + node2.info) % 10)
    node1 = node1.next
    node2 = node2.next
  end

  appendlist(sum, node, carry)
end

def appendlist(sum, node)
  until node.next == nil
    sum.append(node.info + carry)
    carry = 0
    node = node.next
  end

  sum
end

# ===================================
# Intersection: Given 2 (singly) linked lists, determine if the two lists intersect. Return the intersecting node. Note that the intersection is defined based on reference, not value. That is, if the kth node of the first linked list is the exact same node (by reference) as the jth node of the second linked list, then they are intersecting.

def intersect?(l1, l2)
  map = Hash.new(true)

  node1 = l1.first
  node2 = l2.first

  until node1.next == nil && node2.next == nil
    return true if node1 == node2
    return true if map[node1] || map[node2]
    map[node1] = true
    map[node2] = true
    node1 = node1.next unless node1.next == nil
    node2 = node2.next unless node2.next == nil
  end

  false
end

def intersects?(l1, l2)
  first_list = lastlength(l1)
  second_list = lastlength(l2)

  return false unless first_list.last.val == second_list.last.val

  diff = (
    first_list[0] > second_list[0] ?
    first_list[0] - second_list[0] :
    second_list[0] - first_list[0]
  )

  node1 = l1.first
  node2 = l2.first

  diff.times do {}
end

def lastlength(list)
  i = 1
  node = list.first
  until node.next == nil
    i += 1
    node= node.next
  end

  [i, node]
end
