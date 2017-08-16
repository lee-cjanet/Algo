class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return [].hash if self == []
    hash = 0
    self.each_with_index do |el, idx|
      hash += el.hash * idx.hash
    end
    hash
  end
end

class String
  def hash
    return "".hash if self == ""
    hash = 0
    self.chars.each_with_index do |chr, idx|
      hash += chr.ord.hash * idx.hash
    end
    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    return {}.hash if self == {}
    hash = 0
    self.each do |k,v|
      hash += k.to_s.chars.hash * v.to_s.chars.hash
    end
    hash
  end
end
