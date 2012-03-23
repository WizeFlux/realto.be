class District
    include Mongoid::Document
    
    field :title, type: String, localize: true
    
    has_many :estates
end
