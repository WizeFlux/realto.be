class Datesrange
    include Mongoid::Document
    include Mongoid::MultiParameterAttributes
  
    field :start, type: DateTime, default: -> {Date.today}
    field :finish, type: DateTime, default: -> {Date.today}
    
    embedded_in :season
end
