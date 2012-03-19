class EstatePricelistController < ApplicationController
    include Traits::Resource    
    include Traits::ParentResource
    include Traits::Actions::Update
    
    before_filter :find_parent_resource
    before_filter :find_resource

    def find_resource
        self.current_resource = current_parent_resource.pricelist
    end
    
    def post_update_location
        estate_pricelist_url
    end
end
