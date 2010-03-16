require File.join(File.dirname(__FILE__), '/spec_helper')

describe Ohm::Model do
  provide :attributes do
    subject {
      Video.create!(:url => "http://localhost/")
    }

    ######################################################################
    ### Attribute

    its(:attributes) { should be_kind_of(Hash) }

    it "should contain given attribute" do
      subject.attributes[:url].should == "http://localhost/"
    end

    ######################################################################
    ### Counter

    it "should contain given counter" do
      subject.attributes[:viewed].should == 0
    end

    it "should contain a valid counter value after incr and reload" do
      subject.incr(:viewed)
      subject.attributes[:viewed].should == 1
      Video[subject.id].attributes[:viewed].should == 1
    end

    ######################################################################
    ### Set

    it "should contain given set as array" do
      subject.tags.concat "foo"
      subject.attributes[:tags].should be_kind_of(Array)
    end

    it "should contain given set" do
      subject.tags.concat "foo"
      subject.attributes[:tags].should == ["foo"]
    end

    it "should contain given set as array" do
      subject.tags.concat "foo"
      subject.tags.concat "bar"
      subject.attributes[:tags].should == ["foo", "bar"]
    end

    it "should contain empty array when no set given" do
      subject.attributes[:tags].should == []
    end
  end
end
