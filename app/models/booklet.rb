class Booklet
    include Mongoid::Document

    field :title, type: String, localize: true
    field :content, type: String, localize: true
    field :avatar_id, type: String
    
    def avatar
        Image.find(avatar_id) if !avatar_id.blank?
    end

    before_save :collect_features_ids
    
    def collect_features_ids
        describable.update_attributes!(:features_ids => describable.features) if describable.kind_of? Estate
    end

    def format!
        RedCloth.new(imagefull_content).to_html
    end
    
    def imagefull_content
        (content || ' ').gsub(/#.{1,4}#/) do |s|
            image = images.where({:uid => s[1..4]}).first
            "<a class='thumbnail thumb colorbox' rel='box' href='#{image.image.lightbox.url}'><img src='#{image.image.medium.url}' class='medium'/></a>" unless image.nil?
        end
    end
    
    def able_to_update?(person)
        describable.able_to_update?(person)
    end
    
    def able_to_create?(person)
        describable.able_to_create?(person)
    end
    
    def able_to_destroy?(person)
        describable.able_to_destroy?(person)
    end
    
    embedded_in :describable, polymorphic: true
    has_and_belongs_to_many :images

    embeds_many :tags, cascade_callbacks: true
    accepts_nested_attributes_for :tags, :allow_destroy => true
end
