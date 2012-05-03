class Price
    include Mongoid::Document

    field :value, type: Integer, default: 0
    field :accommodation_id
    field :season_id
    field :leasespan_id
    
    
    def outdated?
        leasespan.nil? || season.nil? || accommodation.nil?
    end
    
    def accommodation
        pricelist.accommodations.find accommodation_id if accommodation_id
    end
    
    def season
        pricelist.seasons.find season_id if season_id
    end
    
    def leasespan
        pricelist.leasespans.find leasespan_id if leasespan_id
    end
        
    embedded_in :pricelist
end
