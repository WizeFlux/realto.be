module Traits::Actions
  module Destroy
  
    def destroy
      if resource_destroy
        resource_destroy_success
      else
        resource_destroy_failure
      end
    end
    
    protected

    def resource_destroy
      current_resource.destroy
    end

    def resource_destroy_success
      respond_to do |format|
        format.html {redirect_to post_destroy_location}
        format.js
      end
    end

    def resource_destroy_failure
      redirect_to "/"
    end

    def post_destroy_location
      "/"
    end

  end
end