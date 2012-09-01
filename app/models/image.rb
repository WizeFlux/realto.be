class Image
    include Mongoid::Document
    
    mount_uploader :image, ImageUploader
    field :uid, type: String, default: ->{ rand(36**4).to_s(36) }
    
end
