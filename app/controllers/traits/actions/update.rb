module Traits::Actions
  module Update
    def update
      if resource_update
        resource_update_success
      else
        resource_update_failure
      end
    end
    
    protected

    def resource_update
      self.current_resource.update_attributes(resource_attributes)
    end

    def resource_update_success
      redirect_to post_update_location
    end

    def resource_update_failure
      render :edit
    end

    def post_update_location
      current_resource
    end
  end
end