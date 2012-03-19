class Tag
    include Mongoid::Document
    field :feature_id, type: String
    field :text, type: String, localize: true
    
    def feature
        Feature.find(feature_id)
    end
    
    embedded_in :booklet
end
