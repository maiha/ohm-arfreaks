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

    class Page < Ohm::Model
      attribute :url
    end

    Page.first
    # => #<Page:1 url="http://...">

    Page.create!(:url=>...)

    Page.new.save!


Homepage
--------

  http://github.com/maiha/ohm-arfreaks


Author
------

  maiha@wota.jp
