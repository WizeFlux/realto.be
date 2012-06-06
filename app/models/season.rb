class Season
    include Mongoid::Document

    field :title, localize: true, default: ''

    after_save :populate_fillings

    scope :order, order_by([[:start, :asc]])

    def populate_fillings
        title_translations.each do |key, value|
            Filling.find_or_create_by(
                :model => 'Season',
                :field => 'title',
                :lang => key,
                :text => value
            ) if key && value
        end
    end
    
    embeds_many :datesranges, cascade_callbacks: true
    accepts_nested_attributes_for :datesranges, :allow_destroy => true
    
    embedded_in :pricelist
end