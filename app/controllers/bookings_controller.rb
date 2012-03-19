class BookingsController < ApplicationController
    include Traits::Resource
    include Traits::Authentication
    include Traits::Actions::Destroy
    include Traits::Actions::Update
    include Traits::Actions::Create
    
    helper_method :current_parent_resource
    
    def resource_destroy_success
      render :js => "$('##{current_resource.id.to_s}').remove();"
    end
end
