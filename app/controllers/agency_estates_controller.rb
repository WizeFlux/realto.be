class AgencyEstatesController < EstatesController
    include Traits::ParentResource
    
    before_filter :find_parent_resource
    before_filter :new_resource, :only => %w[new create index]
    before_filter :find_resources, :only => %w[index]
    before_filter :find_resource, :only => %w[show update edit destroy delete]

    def find_resources_process
        scope_modify(:where, {:agency_id => parent_resource_param})
        scope_modify(:includes, :district)
        scope_modify(:excludes, {:hidden => true}) unless editable?
        if q
            scope_modify(:where, {:features_ids.all => features}) if features
            scope_modify(:where, {:"pricelist.accommodations".elem_match => {:bedrooms => {'$gte' => q[:beds_from].to_i, '$lte' => q[:beds_to].to_i}}})
            scope_modify(:where, {:district_id => selected_district}) if selected_district
            if selected_days >= 1
                current_resources.each {|estate| estate.create_pricings(checkin, checkout)}
                scope_modify(:where, {:pricings.elem_match => {checkin: checkin, checkout: checkout, actual: true}})
            end
        end
        
    end

    def resource_attributes
        (super || {}).merge!({:agency => current_parent_resource})
    end
    
    def parent_resource_param
      agency_param_from_domain
    end
end