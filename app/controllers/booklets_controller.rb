class BookletsController < ApplicationController
    include Traits::Actions::Update
    include Traits::Actions::Create
    include Traits::Actions::Destroy
    include Traits::Resource
    
    helper_method :current_parent_resource
    
    def resource_attributes
        (params[:booklet] || {}).merge!({
            :image_ids => extract_images_from_params,
            :avatar_id => params[:avatar]
        })
    end
    
    def resource_scope
        current_parent_resource.booklets
    end
    
    def extract_images_from_params        
        params[:images].blank? ? [] : params[:images].values
    end
end
