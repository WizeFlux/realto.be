class AgencyController < ApplicationController
    include Traits::Resource
    include Traits::Actions::Update
  
    before_filter :find_resource, :only => %w[show edit update]
    
    def resource_param
        agency_param_from_domain
    end
    
    def post_update_location
        agency_url(:format => request.format.to_sym)
    end
end
