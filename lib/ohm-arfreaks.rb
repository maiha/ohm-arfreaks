module Ohm
  class Model
    ######################################################################
    ### Validations

    RecordNotSaved = Class.new(RuntimeError)

    def self.create!(attributes)
      object = new(attributes)
      object.save!
      object
    end

    def save!
      save || raise(RecordNotSaved)
    end

    ######################################################################
    ### Accessor methods

    def self.first(*args)
      (args.empty? ? all : find(*args)).first
    end

    def self.last(*args)
      (args.empty? ? all : find(*args)).last
    end

    # TODO: should use native 'count' method for performance reason
    def self.count(*args)
      (args.empty? ? all : find(*args)).size
    end
  end
end
