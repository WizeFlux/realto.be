module Traits::Actions
  module Create
    def create
      if resource_create
        resource_create_success
      else
        resource_create_failure
      end
    end
    
    protected
  
    def new_resource
      self.current_resource = resource_scope.new resource_attributes
    end

    def post_create_location
      current_resource
    end 

    def resource_create
      self.current_resource.save
    end

    def resource_create_success
      redirect_to post_create_location
    end

    def resource_create_failure
      render :new
    end 
  end
end