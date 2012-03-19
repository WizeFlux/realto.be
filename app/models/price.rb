class Price
    include Mongoid::Document

    field :value, type: Integer, default: 0
    field :season_id
    field :leasespan_id
    
    def outdated?
        leasespan.nil? || season.nil?
    end
    
    def season
        pricelist.seasons.where(_id: season_id.to_s).first
    end
    
    def leasespan
        pricelist.leasespans.where(_id: leasespan_id.to_s).first
    end
        
    embedded_in :pricelist
end