class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 0

    self.each_with_index { |el, idx| hash = hash ^ (el.hash + idx.hash) }
    hash
  end
end

class String
  def hash
    self.chars.map { |chr| chr.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = 0
    self.to_a.each do |arr|
      hash += arr.hash
    end
    hash
  end
end
