class Leasespan
    include Mongoid::Document
    
    field :from, type: Integer
    field :to, type: Integer
  
    embedded_in :pricelist
end
