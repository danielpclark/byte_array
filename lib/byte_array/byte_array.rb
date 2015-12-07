class ByteArray 
  VERSION = "0.9.0"
  
  attr_reader :bytes
  def initialize size = 0, obj = 0
    @bytes = []
    size.times do @bytes << Byte[obj] end
  end
   
  def self.[] array = []
    return array if array.is_a? ByteArray
    b = new
    b.insert 0, *array
    b
  end

  def [] slice
    case slice
    when Range
      ByteArray[@bytes[slice]]
    when Integer
      @bytes[slice]
    end
  end

  def []= slice, *input
    input = input.flat_map(&method(:to_bytes))
    case slice
    when Range
      @bytes[slice] = *input 
    when Integer
      insert slice, *input
    end unless input.empty?
  end

  def length
    @bytes.length
  end

  def inspect
    "ByteArray#{@bytes}"
  end

  def insert position, *what
    assert_in_range position

    what = what.flat_map(&method(:to_bytes))
    @bytes[positioni, what.length] = what unless what.empty?
  end

  def == other
    return false if other.length != @bytes.length
    ByteArray[other].zip(@bytes).all?{|a,b| a == b}
  end
  
  def coerce other
    [ByteArray[other], self]
  end

  def to_ary
    @bytes
  end

  def to_a
    @bytes
  end

  def method_missing m, *a, &b
    #puts "Method #{m} called with", *a
    @bytes.send m, *a, &b
  end

  private
  # to_bytes always returns Array of Bytes
  def to_bytes input
    b = case input
    when String
      input.unpack("C*")
    when Integer
      raise RangeError, "Integer #{input} is to large to be a Byte" unless input < 256
      [input]
    when Byte
      return [input]
    when Array
      input
    when NilClass
      []
    else
      raise TypeError, "Unexpected type #{input.class} for ByteArray#to_bytes"
    end
    b.map &Byte
  end

  def assert_in_range index
    unless (0..@bytes.length).include? index
      raise RangeError,
        "Range Exceeded! #{index} is outside of 0..#{@bytes.length}"
    end
    true
  end
end
