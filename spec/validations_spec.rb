require File.join(File.dirname(__FILE__), '/spec_helper')

describe Video do
  it do
    Video.should provide(:create!)
  end

  provide :save!
end
