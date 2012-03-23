class Map
    include Mongoid::Document
    include Mongoid::Spacial::Document
    
    field :location, type: Array, spacial: true, default: [115.18219874902343, -8.410910012297114]
    field :zoom, type: Integer, default: 10
    field :center, type: Array, spacial: true, default: [115.15404028320313, -8.459813661126972]
    
    def able_to_update?(person)
        locatable.able_to_update?(person)
    end
    
    def able_to_create?(person)
        locatable.able_to_create?(person)
    end
    
    def able_to_destroy?(person)
        locatable.able_to_destroy?(person)
    end
    
    embedded_in :locatable, polymorphic: true
end
