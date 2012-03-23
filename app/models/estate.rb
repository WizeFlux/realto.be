class Estate
    include Mongoid::Document
    include Mongoid::Spacial::Document

    field :title, localize: true
    field :teaser, localize: true
    field :slug, type: String

    field :bedrooms, type: Integer, :default => 1
    field :adults_max, type: Integer, :default => 1
    field :childs_max, type: Integer, :default => 0
    
    field :features_ids, type: Array, :default => []
    field :average_price, type: Integer, :default => 0

    key :slug

    after_create :create_booklet, :create_pricelist, :create_map

    embeds_one :pricelist
    embeds_one :booklet, :as => :describable
    embeds_one :map, :as => :locatable
    
    embeds_many :pricings
    
    def able_to_update?(person)
        agency.able_to_update?(person)
    end
    
    def able_to_create?(person)
        agency.able_to_create?(person)
    end
    
    def able_to_destroy?(person)
        agency.able_to_destroy?(person)
    end
    
    belongs_to :agency
    has_many :bookings
end
