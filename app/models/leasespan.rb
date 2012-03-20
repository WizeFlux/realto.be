class Leasespan
    include Mongoid::Document
    
    field :from, type: Integer
    field :to, type: Integer
    
    scope :order!, order_by([[:from, :asc]])
    
    embedded_in :pricelist
end
