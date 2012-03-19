class Choice
    include Mongoid::Document
    field :title, localize: true
    field :price, type: Integer
    
    after_save :populate_fillings
    
    def populate_fillings
        logger.info self.inspect
        title_translations.each do |key, value|
            Filling.find_or_create_by(
                :model => 'Choice',
                :field => 'title',
                :lang => key,
                :text => value
            ) if key && value
        end
    end
    
    embedded_in :pricelist
end
