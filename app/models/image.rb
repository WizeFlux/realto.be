class Image
    include Mongoid::Document
    mount_uploader :image, ImageUploader
    
    field :uid, type: String, default: ''
    
    before_save :generate_uid
    
    def generate_uid
        self.uid = rand(36**4).to_s(36)
    end
end
