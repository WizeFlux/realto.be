class AgencyMapController < MapController
    include Traits::ParentResource

    before_filter :find_parent_resource
    before_filter :find_resource
    
    def parent_resource_param
        agency_param_from_domain
    end
    
    def post_update_location
        agency_map_url
    end
end
