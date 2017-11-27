# override the as_json method in BSON 
module BSON
  class ObjectId
    def as_json(*args)
      # Override this 
      # { "$oid" => to_s }
      # to this
      # to_s is a string representation of object id 
      # it's a method defined inside ObjectId class
      to_s 
    end
  end 
end 
