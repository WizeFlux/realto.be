class Pricelist
    include Mongoid::Document
    
    before_save :price_control, :collect_average_price

    def collect_average_price
        estate.update_attributes!(:average_price => prices.map(&:value).instance_eval{reduce(:+) / size.to_f}) if prices.exists?
    end
    
    def price_control
        prices.each {|price| price.delete if price.outdated?}
        leasespans.each do |leasespan|
            seasons.each do |season|
                prices.find_or_create_by(leasespan_id: leasespan.id, season_id: season.id)
            end
        end
    end
    
    def price_for(day, days)
        if !leasespans.where(:from.lte => days, :to.gte => days).to_a.empty? && !seasons.where(:start.lte => day, :finish.gte => day).to_a.empty?
            prices.where(
                :leasespan_id => leasespans.where(:from.lte => days, :to.gte => days).first.id,
                :season_id => seasons.where(:start.lte => day, :finish.gte => day).first.id
            ).first
        else
            false
        end
    end
    
    def format!
        RedCloth.new(content).to_html
    end
    
    def min_price
        prices.map(&:value).min
    end
    
    def max_price
        prices.map(&:value).max
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
    
    embeds_many :seasons, cascade_callbacks: true
    accepts_nested_attributes_for :seasons, :allow_destroy => true

    embeds_many :leasespans
    accepts_nested_attributes_for :leasespans, :allow_destroy => true    
    
    embeds_many :prices
    accepts_nested_attributes_for :prices, :allow_destroy => true
    
    embedded_in :estate
end
