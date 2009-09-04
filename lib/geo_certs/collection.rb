module GeoCerts
  
  ##
  # A GeoCerts::Collection is used whenever a collection of GeoCerts objects is returned from
  # this library.  It adds the additional attributes of +end_at+ and +start_at+, representing
  # the DateTime range from which the collection contains data.
  # 
  class Collection < Array
    attr_accessor :end_at, :start_at
  end
  
end
