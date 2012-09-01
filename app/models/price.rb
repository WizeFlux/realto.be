class Price
    include Mongoid::Document

    field :value, type: Integer, default: 0
    field :accommodation_id, type: Moped::BSON::ObjectId
    field :season_id, type: Moped::BSON::ObjectId
    field :leasespan_id, type: Moped::BSON::ObjectId

    def outdated?
        id if (leasespan.nil? || season.nil? || accommodation.nil?)
    end
    
    def accommodation
        pricelist.accommodations.where(_id: accommodation_id).first
    end
    
    def season
        pricelist.seasons.where(_id: season_id).first
    end
    
    def leasespan
        pricelist.leasespans.where(_id: leasespan_id).first
    end
        
    embedded_in :pricelist
end
