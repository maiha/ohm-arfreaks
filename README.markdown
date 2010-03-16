Ohm ARFreaks
============

Ohm::Model extensions for AR freaks


Install
-------

    $ sudo gem install ohm-arfreaks


Models
------

AR freaks will be puzzled that Ohm::Model lacks well known methods like first, count, etc.
This library provides some of them to Ohm::Model.

### Example

    require 'ohm-arfreaks'

    class Video < Ohm::Model
      attribute :url
      set       :tags
    end

    Video.first
    => #<Video id: 470, url: "a", tags: []>

    Video.create!(:url=>...)
    Video.new.save!

### Available Methods

    def self.primary_key        # AR
    def self.columns            # AR
    def self.column_names       # AR
    def self.content_columns    # AR
    def self.columns_hash       # AR
    def self.create!(attributes) # AR
    def save!                   # AR
    def self.first(*args)       # AR
    def self.last(*args)        # AR
    def self.count(*args)       # AR
    def self.delete_all(cond = nil) # AR
    def new_record?             # AR
    def attributes              # AR

    (reported by: % grep 'def ' lib/ohm-arfreaks.rb |grep '# AR' )

### NOTE

  Ohm::Model#attributes returns an names of attributed fields in vanilla ohm gem.
  Of course, it's not familier to our ar-freaks, so it's overwritten by this gem.

     class Video < Ohm::Model
       attribute :url
       set       :tags
     end

     Video.first.attributes
     => [:url]                   # in vanilla ohm
     => {:url=>"a", :tags=>[]}   # in ohm-arfreaks


Test
----

    % redis-server spec/redis.conf   # running on port:6380 in default
    % spec -c spec


Homepage
--------

  http://github.com/maiha/ohm-arfreaks


Author
------

  maiha@wota.jp
