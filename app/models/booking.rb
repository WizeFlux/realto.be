class Booking
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  
  field :status, type: String, default: 'New'
  
  def self.statuses
      ['New', 'Confirmed', 'Invoice', 'Paid', 'Voucher']
  end
  
  field :price, type: Integer, default: 0
  
  field :checkin, type: Date, default: -> {Date.today}
  field :checkout, type: Date, default: -> {Date.today}
  
  field :adults, type: Integer, :default => 1
  field :children, type: Integer, :default => 0
  
  field :addressing, type: String
  field :email, type: String
  field :phone, type: String
  field :skype, type: String
  
  field :message, type: String
  
  def able_to_update?(person)
      agency.able_to_update?(person)
  end
  
  def able_to_create?(person)
      true
  end
  
  def able_to_destroy?(person)
      false
  end
  
  
  belongs_to :customer, :class_name => 'Person'
  belongs_to :agency
  belongs_to :estate
end
