class Person
    include Mongoid::Document
    
    field :name
    field :password
    field :email
    field :token
    field :fb_uid
    field :fb_url
    
    def generate_token!(salt)
        self.token = id.to_s.crypt(salt.to_s) + name.crypt(salt.to_s) + email.crypt(salt.to_s)
    end

    has_many :bookings, :inverse_of => :customer, :class_name => 'Booking'
    has_one :agency, :inverse_of => :owner, :class_name => 'Agency'
end