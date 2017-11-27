class Record
  include Mongoid::Document
  field :name, type: String
  field :grade, type: Integer
  field :roll, type: Integer

  
end
