class EstateBookletsController < BookletsController
    include Traits::ParentResource
    
    before_filter :find_parent_resource
    before_filter :find_resource, :except => %w[new create]
    before_filter :new_resource, :only => %w[new create]
    
    def post_create_location
        post_update_location
    end
    
    def post_destroy_location
        estate_url(@estate)
    end

    def post_update_location
        estate_booklet_url(@estate, @booklet)
    end
end
