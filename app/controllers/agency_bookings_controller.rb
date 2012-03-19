class AgencyBookingsController < BookingsController
    include Traits::ParentResource
    include Traits::Actions::Create
    
    before_filter :find_parent_resource
    before_filter :find_resources, :only => %w[index]
    before_filter :new_resource, :only => %w[index]
    
    def resource_attributes
      resource_conditions
    end
    
    def resource_conditions
      {:agency_id => parent_resource_param}
    end
    
    def parent_resource_param
      agency_param_from_domain
    end
end
