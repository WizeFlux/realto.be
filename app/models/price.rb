class Price
    include Mongoid::Document

    field :value, type: Integer, default: 0
    field :accommodation_id
    field :season_id
    field :leasespan_id
    
    
    def outdated?
        !leasespan.exists? || !season.exists? || !accommodation.exists?
    end
    
    def accommodation
        pricelist.accommodations.where(id: accommodation_id)
    end
    
    def season
        pricelist.seasons.where(id: season_id)
    end
    
    def leasespan
        pricelist.leasespans.where(id:leasespan_id)
    end
        
    embedded_in :pricelist
end
