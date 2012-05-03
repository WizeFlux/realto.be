class Estate
    include Mongoid::Document

    field :title, localize: true
    field :teaser, localize: true
    field :slug, type: String
    
    field :features_ids, type: Array, :default => []
    
    field :average_price, type: Integer, :default => 0
    field :max_bedrooms, type: Integer, :default => 0
    field :min_bedrooms, type: Integer, :default => 0
    
    field :comment, type: String
    field :comission, type: String
    field :margin, type: String
    
    key :slug
    
    def features
        booklets.inject([]){|i,b| i << b.tags.map(&:feature_id)}.flatten.uniq
    end

    def able_to_update?(person)
        agency.able_to_update?(person)
    end
    
    def able_to_create?(person)
        agency.able_to_create?(person)
    end
    
    def able_to_destroy?(person)
        agency.able_to_destroy?(person)
    end

    after_create :create_pricelist, :create_map
    accepts_nested_attributes_for :contacts, :allow_destroy => true
    
    has_many :bookings
    embeds_one :pricelist
    embeds_one :map, :as => :locatable
    embeds_many :booklets, :as => :describable
    embeds_many :contacts
    embeds_many :pricings
    belongs_to :district
    belongs_to :agency    
end
