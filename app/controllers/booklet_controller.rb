class BookletController < ApplicationController
    include Traits::Actions::Update
    include Traits::Resource
    
    helper_method :current_parent_resource
    
    def resource_attributes
        params[:booklet].merge!({:image_ids => extract_images_from_params, :avatar_id => params[:avatar]})    
    end 
    
    def extract_images_from_params        
        params[:images].blank? ? [] : params[:images].values
    end
    
    def find_resource
        self.current_resource = current_parent_resource.booklet
    end
end
