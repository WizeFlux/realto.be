class Booking
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  
  field :status, type: String, default: 'New'
  
  def self.statuses
      ['New', 'Confirmed', 'Invoice', 'Paid', 'Voucher']
  end
  
  field :accommodation_id
  
  def accommodation
      estate.pricelist.accommodations.where(_id: accommodation_id.to_s).first
  end
  
  field :price, type: Integer, default: 0
  
  def count_price
    estate.pricings.find_or_create_by({
      :checkin => checkin,
      :checkout => checkout,
      :accommodation_id => accommodation_id.to_s}).total
  end
  
  field :checkin, type: Date, default: -> {Date.today}
  field :checkout, type: Date, default: -> {Date.today}
  
  field :adults, type: Integer, :default => 1
  field :children, type: Integer, :default => 0
  
  field :addressing, type: String, default: -> {customer ? customer.name : nil}
  validates_presence_of :addressing
  
  field :email, type: String, default: -> {customer ? customer.email : nil}
  validates_presence_of :email
  
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
