class Byte
  def initialize val
    @value = case val
    when Integer
      raise RangeError, "#{val} is too large for Byte" if val > 255
      val
    when String
      raise RangeError, "#{val} is too large for Byte" if val.length > 1
      val.unpack("C").first
    else
      raise TypeError, "Wrong type #{val.class} for Byte"
    end
  end

  def self.[] obj;     obj.is_a?(Byte) ? obj : Byte.new(obj)    end
  def self.to_proc;    ->obj{self[obj]}                         end

  def inspect;     @value                end
  def to_i;        @value                end
  def to_s;        [@value].pack("C")    end
  def to_str;      to_s                  end
  def == o;        o.to_i == @value      end
  def coerce o;    [o.to_i, @value]      end
  def + o;         @value + o.to_i       end
  def - o;         @value - o.to_i       end
  def * o;         @value * o.to_i       end
  def / o;         @value / o.to_i       end
end
