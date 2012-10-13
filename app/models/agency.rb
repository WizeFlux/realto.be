class Agency
    include Mongoid::Document
    
    field :subdomain
    field :host
    
    field :_id, type: String, default: ->{ subdomain }
    
    after_create :create_map
    before_save :clear_operating_languages
    
    field :title, localize: true, default: ' '
    field :teaser, localize: true, default: ' '
    field :default_language, type: String, default: 'en'
    field :operating_languages, type: Array, default: ['en', 'ru']
    field :keywords, type: String
    field :seo_script, type: String
    
    def self.avaiable_languages
        ['en', 'ru']
    end
    
    def clear_operating_languages
        operating_languages.delete("")
        logger.info operating_languages
    end
    
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
    
    embeds_one :map, :as => :locatable
    embeds_many :booklets, :as => :describable
    
    embeds_many :contacts
    accepts_nested_attributes_for :contacts, :allow_destroy => true
end