class Filling
  include Mongoid::Document
  field :text, type: String
  field :lang, type: String
  field :model, type: String
  field :field, type: String
end
