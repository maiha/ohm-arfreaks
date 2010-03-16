require File.join(File.dirname(__FILE__), '/spec_helper')

describe Ohm::Model do
  ######################################################################
  ### delete_all

  it do
    Ohm::Model.should provide(:delete_all)
  end

  describe ".delete_all" do
    before do
      Video.create!(:url=>"a")
      @count = Video.count
    end

    it "should delete all records" do
      lambda { Video.delete_all }.should change(Video, :count).from(@count).to(0)
    end

    it "should raise NotImplementedError when args are given" do
      lambda { Video.delete_all(:some_cond) }.should raise_error(NotImplementedError)
    end
  end

  context "(url 'a' and 'b')" do
    before do
      Video.delete_all
      Video.create!(:url=>"a")
      Video.create!(:url=>"b")
    end

    ######################################################################
    ### first
    it do
      Ohm::Model.should provide(:first)
    end

    describe ".first" do
      it "should return an record" do
        # TODO: how to know the orders
        Video.first.url.should match(/\Aa|b\Z/)
      end
    end

    ######################################################################
    ### all

    it do
      Ohm::Model.should provide(:all)
    end

    describe ".all" do
      it "should return all records" do
        Video.all.map(&:url).sort.should == ["a", "b"]
      end
    end

    ######################################################################
    ### last

    it do
      Ohm::Model.should provide(:last)
    end

    describe ".last" do
      it "should return an record" do
        # TODO: how to know the orders
        Video.last.url.should match(/\Aa|b\Z/)
      end
    end
  end

  ######################################################################
  ### new_recoard?

  provide :new_record? do
    it "should return true for non saved record" do
      Video.new.new_record?.should == true
    end

    it "should return false for existing record" do
      Video.create!(:url=>"a").new_record?.should == false
    end
  end
end
