class EstateBookingsController < BookingsController
    include Traits::ParentResource

    before_filter :find_parent_resource
    before_filter :new_resource, :only => %w[new create index]
    before_filter :find_resources, :only => %w[index]
    before_filter :find_resource, :only => %w[delete destroy update show edit]
  
    def resource_conditions
        {:estate_id => parent_resource_param}
    end
  
    def resource_attributes
        (super || {}).merge!({
            :estate => @estate,
            :agency => @estate.agency,
        })
    end
  
    def post_create_location
        estate_booking_url(@estate, @booking)
    end
  
    def create_success_flash
        t 'notices.booking.success'
    end
  
    def post_update_location
        estate_booking_url(@estate, @booking)
    end
end
