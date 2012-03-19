class Agency
    include Mongoid::Document
    
    field :subdomain
    key :subdomain
    
    after_create :create_booklet
    
    field :title, localize: true
    field :teaser, localize: true
  
    def able_to_update?(person)
        person == owner
    end
    
    def able_to_create?(person)
        person == owner
    end
    
    def able_to_destroy?(person)
        person == owner
    end
    
  
    belongs_to :owner, :class_name => 'Person'
    
    has_many :bookings
    has_many :estates
    
    embeds_one :booklet, :as => :describable
    
    embeds_many :contacts
    accepts_nested_attributes_for :contacts, :allow_destroy => true
end