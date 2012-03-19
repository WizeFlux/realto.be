class EstatePricingController < ApplicationController
    include Traits::ParentResource
    include Traits::Resource

    before_filter :find_parent_resource
    before_filter :find_resource
    
    def find_resource
      self.current_resource = current_parent_resource.pricings.find_or_create_by resource_attributes
    end
end
