class AgencyEstatesController < EstatesController
    include Traits::ParentResource
    
    before_filter :find_parent_resource
    before_filter :new_resource, :only => %w[new create index]
    before_filter :find_resources, :only => %w[index]
    before_filter :find_resource, :only => %w[show update edit destroy delete]
    
    def lookup_resources
        r = Estate.where(:agency_id => current_parent_resource.id).includes(:district)
        
        r = r.excludes(:hidden => true) unless current_resource.able_to_update?(current_person)
        
        if q
            r = r.where(:features_ids.all => features) if features
            r = r.where(:"pricelist.accommodations".elem_match => {:bedrooms => {'$gte' => q[:beds_from].to_i, '$lte' => q[:beds_to].to_i}})            
            r = r.where(:district_id => Moped::BSON::ObjectId(q[:district_id]) ) unless q[:district_id].blank?
            if selected_days >= 1
                r.each do |estate| 
                    estate.pricelist.accommodations.each do |accommodation|
                        estate.pricings.find_or_create_by(  :checkin => checkin,
                                                            :checkout => checkout,
                                                            :accommodation_id => accommodation.id)
                    end
                end
                r = r.where(:pricings.elem_match => {   :checkin => checkin,
                                                        :checkout => checkout,
                                                        :actual => true  })
            end
        end
        r.order_by(resource_sort_conditions)
    end

    def resource_attributes
        (super || {}).merge!({
            :agency => @agency,
        })
    end
    
    def parent_resource_param
      agency_param_from_domain
    end
end