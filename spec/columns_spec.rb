require File.join(File.dirname(__FILE__), '/spec_helper')

describe Ohm::Model do
  ######################################################################
  ### columns

  it do
    Video.should provide(:columns)
  end

  describe ".columns" do
    it "should return an array of Column" do
      Video.columns.map(&:class).should == [Ohm::Model::Column, Ohm::Model::Column, Ohm::Model::Column, Ohm::Model::Column]
    end

    it "should contains column names" do
      Video.columns.map(&:name).should == [:id, :url, :tags, :viewed]
    end

    it "should contains column types" do
      Video.columns.map(&:type).should == [:attribute, :attribute, :collection, :counter]
    end
  end

  ######################################################################
  ### column_names

  it do
    Video.should provide(:column_names)
  end

  describe ".column_names" do
    it "should return an array of Symbol" do
      Video.column_names.map(&:class).uniq.should == [Symbol]
    end

    it "should return column names" do
      Video.column_names.should == [:id, :url, :tags, :viewed]
    end
  end

  ######################################################################
  ### content_columns

  it do
    Video.should provide(:content_columns)
  end

  describe ".content_columns" do
    it "should return an array of Column" do
      Video.content_columns.map(&:class).uniq.should == [Ohm::Model::Column]
    end

    it "should contains only attribute columns" do
      Video.content_columns.map(&:type).uniq.should == [:attribute]
    end

    it "should not contains primary keys" do
      Video.content_columns.map(&:name).should_not include(:id)
    end
  end

  ######################################################################
  ### columns_hash

  it do
    Video.should provide(:columns_hash)
  end

  describe ".columns_hash" do
    it "should return a hash" do
      Video.columns_hash.should be_kind_of(Hash)
    end
  end
end
