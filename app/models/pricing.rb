class Pricing
    include Mongoid::Document
    
    field :checkin, type: DateTime
    field :checkout, type: DateTime
    field :days, type: Integer, default: -> {(checkout.to_date - checkin.to_date).to_i}
    field :total, type: Integer, default: 0
    field :actual, type: Boolean, default: true
    
    embedded_in :estate
    
    before_create :collect!
    
    def collect!
        if checkin > checkout
            self.actual = false
            return false
        end
        (checkin..(checkout - 1.day)).each do |day|
            if estate.pricelist.price_for(day, days)
                self.total += estate.pricelist.price_for(day, days).value
            else
                self.actual = false
                return false
            end
        end
        return true
    end
end