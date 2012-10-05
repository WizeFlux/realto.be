class Estate
    include Mongoid::Document

    field :title, localize: true
    validates_presence_of :title
    field :_id, type: String, default: ->{ Moped::BSON::ObjectId.new}
    
    field :teaser, localize: true
    field :features_ids, type: Array, :default => []
    
    field :average_price, type: Integer, :default => 0
    field :max_bedrooms, type: Integer, :default => 0
    field :min_bedrooms, type: Integer, :default => 0
    
    field :comment, type: String
    field :comission, type: String
    field :margin, type: String
    field :hidden, type: Boolean, default: false    
    
    def create_pricings(checkin, checkout)
      pricelist.accommodations.each do |accommodation|
        pricings.find_or_create_by(checkin: checkin, checkout: checkout, accommodation_id: accommodation.id)
      end
    end
    
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
    
    embeds_many :contacts
    accepts_nested_attributes_for :contacts, :allow_destroy => true
    
    embeds_one :pricelist
    embeds_one :map, :as => :locatable
    embeds_many :booklets, :as => :describable
    embeds_many :pricings
    
    has_many :bookings
    belongs_to :district
    validates_presence_of :district_id
    belongs_to :agency    
end
