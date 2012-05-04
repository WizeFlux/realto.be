class Pricelist
    include Mongoid::Document
    
    before_save :pricings_control, :update_estate_information, :prices_control
    
    def prices_control
        prices.any_in(_id: prices.map(&:outdated?).compact).delete_all
    end
    
    def update_estate_information
        estate.update_attributes(
            average_price: accommodations.map(&:average_price).inject(:+) / accommodations.count,
            max_bedrooms: accommodations.map(&:bedrooms).max,
            min_bedrooms: accommodations.map(&:bedrooms).min
        ) if prices.exists?
    end
    
    def pricings_control
        estate.pricings.delete_all
    end
    
    def price_for(day, days, accommodation_id)
        if !leasespans.where(:from.lte => days, :to.gte => days).to_a.empty? && !seasons.where(:start.lte => day, :finish.gte => day).to_a.empty?
            prices.where(
                :leasespan_id => leasespans.where(:from.lte => days, :to.gte => days).first.id,
                :season_id => seasons.where(:start.lte => day, :finish.gte => day).first.id,
                :accommodation_id => accommodation_id
            ).first
        else
            false
        end
    end

    def able_to_update?(person)
        estate.able_to_update?(person)
    end
    
    def able_to_create?(person)
        estate.able_to_create?(person)
    end
    
    def able_to_destroy?(person)
        estate.able_to_destroy?(person)
    end
    
    embeds_many :choices, cascade_callbacks: true
    accepts_nested_attributes_for :choices, :allow_destroy => true

    embeds_many :accommodations, cascade_callbacks: true
    accepts_nested_attributes_for :accommodations, :allow_destroy => true
    
    embeds_many :seasons, cascade_callbacks: true
    accepts_nested_attributes_for :seasons, :allow_destroy => true

    embeds_many :leasespans, cascade_callbacks: true
    accepts_nested_attributes_for :leasespans, :allow_destroy => true    
    
    embeds_many :prices, cascade_callbacks: true
    accepts_nested_attributes_for :prices, :allow_destroy => true
    
    embedded_in :estate
end
