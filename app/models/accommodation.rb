class Accommodation
    include Mongoid::Document
    include Mongoid::MultiParameterAttributes

    field :title, localize: true, default: ''
    
    field :bedrooms, type: Integer, :default => 1
    field :adults_max, type: Integer, :default => 1
    field :childs_max, type: Integer, :default => 0
    field :amount, type: Integer, :default => 1
    
    after_save :populate_fillings

    def populate_fillings
        title_translations.each do |key, value|
            Filling.find_or_create_by(
                :model => 'Accommodation',
                :field => 'title',
                :lang => key,
                :text => value
            ) if key && value
        end
    end

    embedded_in :pricelist
end
