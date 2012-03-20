class Season
    include Mongoid::Document
    include Mongoid::MultiParameterAttributes
    
    field :start, type: DateTime, default: -> {Date.today}
    field :finish, type: DateTime, default: -> {Date.today}
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

    embedded_in :pricelist
end
