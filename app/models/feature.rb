class Feature
  include Mongoid::Document
  
  field :title, type: String, localize: true
  field :description, type: String, localize: true
  field :searchable, type: Boolean, :default => false
  
  scope :searchables, where(searchable: true)
end
