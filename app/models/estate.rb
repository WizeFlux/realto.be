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
    
    field :comment, type: String
    field :comission, type: String
    field :margin, type: String
    
    key :slug

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
