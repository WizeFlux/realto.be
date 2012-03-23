class MapController < ApplicationController
    include Traits::Actions::Update
    include Traits::Resource
    
    helper_method :current_parent_resource

    def find_resource
        self.current_resource = current_parent_resource.map
    end
end
