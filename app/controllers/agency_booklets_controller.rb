class AgencyBookletsController < BookletsController
    include Traits::ParentResource

    before_filter :find_parent_resource
    before_filter :find_resource, :except => %w[new create]
    before_filter :new_resource, :only => %w[new create]
        
    def parent_resource_param
        agency_param_from_domain
    end
    
    def post_create_location
        post_update_location
    end
    
    def post_destroy_location
        agency_url(@agency)
    end
    
    def post_update_location
        agency_booklet_url(@booklet)
    end
end
