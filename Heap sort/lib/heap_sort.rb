require_relative "heap"

class Array
  def heap_sort!

    prc ||= Proc.new { |a, b| b <=> a }
    (2..self.count).each do |length|
      BinaryMinHeap.heapify_up(self, length - 1, length, &prc)
    end

    (2..self.count).each do |length|
      reverse_idx = self.count - length + 1
      self[reverse_idx], self[0] = self[0], self[reverse_idx]
      BinaryMinHeap.heapify_down(self, 0, reverse_idx, &prc)
    end

    self
  end

end
