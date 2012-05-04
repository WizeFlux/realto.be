class Tag
    include Mongoid::Document
    field :feature_id, type: String
    field :text, type: String, localize: true
    
    after_save :populate_fillings
    
    def feature
        Feature.find(feature_id)
    end
    
    def populate_fillings
        text_translations.each do |lang, text|
            Filling.find_or_create_by(
                :model => 'Tag',
                :field => 'text',
                :lang => lang,
                :text => text
            ) if lang && text
        end
    end
    
    embedded_in :booklet
end
