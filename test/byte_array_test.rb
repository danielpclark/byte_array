require 'test_helper'

describe ByteArray do
  it "Is versioned" do
    refute_nil ::ByteArray::VERSION
  end
  it "Creates a Byte" do
    assert_equal Byte[1], 1
  end
  it "Creates a ByteArray" do
    assert_equal ByteArray[[1,2,3]], [1,2,3]
  end
end
