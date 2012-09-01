class Pricing
    include Mongoid::Document

    field :checkin, type: DateTime
    field :checkout, type: DateTime
    
    field :days, type: Integer, default: ->{ (checkout.to_date - checkin.to_date).to_i }
    field :total, type: Integer, default: 0
    field :actual, type: Boolean, default: true
    
    field :accommodation_id, type: Moped::BSON::ObjectId
    
    def accommodation
        estate.pricelist.accommodations.find accommodation_id
    end
    
    embedded_in :estate
    
    before_create :collect!
    
    def collect!
        if checkin > checkout
            self.actual = false
            return false
        else
            (checkin..(checkout - 1.day)).each do |day|
                price_for_this_day = estate.pricelist.price_for(day, days, accommodation_id)                
                if price_for_this_day
                    self.total += price_for_this_day.value
                else
                    self.actual = false
                    return false
                end
            end
            return true
        end
    end
end