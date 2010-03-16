module Ohm
  class Model
    ######################################################################
    ### Columns

    Column = Struct.new(:name, :type)

    def self.primary_key        # AR
      :id
    end

    def self.columns            # AR
      [Column.new(primary_key, :attribute)] +
        content_columns +
        [:collection, :counter].map do |type|
        __send__("#{type}s").map{|name| Column.new(name, type)}
      end.flatten
    end

    def self.column_names       # AR
      columns.map(&:name)
    end

    def self.content_columns    # AR
      attributes.map{|name| Column.new(name, :attribute)}
    end

    def self.columns_hash       # AR
      columns.inject({}){|h,c| h[c.name] = c; h}
    end

    ######################################################################
    ### Validations

    RecordNotSaved = Class.new(RuntimeError)

    def self.create!(attributes) # AR
      object = new(attributes)
      object.save!
      object
    end

    def save!                   # AR
      save || raise(RecordNotSaved)
    end

    ######################################################################
    ### Accessor methods

    def self.first(*args)       # AR
      (args.empty? ? all : find(*args))[0]
    end

    def self.last(*args)        # AR
      (args.empty? ? all : find(*args))[-1]
    end

    def self.count(*args)       # AR
      (args.empty? ? all : find(*args)).size
    end

    ######################################################################
    ### ActiveRecord class methods

    def self.delete_all(cond = nil) # AR
      if cond
        raise NotImplementedError, "Sorry, conditional delete_all is not implemented yet"
      else
        all.each(&:delete)
      end
    end

    ######################################################################
    ### ActiveRecord instance methods

    def new_record?             # AR
      new?
    end

    ######################################################################
    ### Overwrite attributes (and related methods)

    def attributes              # AR
      hash = {}
      self.class.attributes.each do |attr|
        hash[attr] = __send__(attr)
      end
      self.class.collections.each do |attr|
        hash[attr] = (begin __send__(attr).to_a; rescue MissingID; []; end)
      end
      self.class.counters.each do |attr|
        hash[attr] = __send__(attr).to_i
      end
      return hash
    end

    def delete
      delete_from_indices
      delete_attributes(self.class.attributes)
      delete_attributes(self.class.counters)
      delete_attributes(self.class.collections)
      delete_model_membership
      self
    end

    def inspect
      attrs = attributes.map{|(k,v)| "#{k}: #{v.inspect}"}.join(', ')
      "#<#{self.class} id: #{new_record? ? "nil" : id}, #{attrs}>"
    end

    # Write attributes using SET
    # This method will be removed once MSET becomes standard.
    def write_with_set
      self.class.attributes.each do |att|
        value = send(att)
        value.to_s.empty? ?
          db.set(key(att), value) :
          db.del(key(att))
      end
    end

    # Write attributes using MSET
    # This is the preferred method, and will be the only option
    # available once MSET becomes standard.
    def write_with_mset
      unless self.class.attributes.empty?
        rems, adds = self.class.attributes.map { |a| [key(a), send(a)] }.partition { |t| t.last.to_s.empty? }
        db.del(*rems.flatten.compact) unless rems.empty?
        db.mset(adds.flatten)         unless adds.empty?
      end
    end
  end
end
