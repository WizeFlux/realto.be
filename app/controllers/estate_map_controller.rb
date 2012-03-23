class EstateMapController < MapController
    include Traits::ParentResource

    before_filter :find_parent_resource
    before_filter :find_resource

    def post_update_location
        estate_map_url
    end
end
