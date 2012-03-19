class EstatesController < ApplicationController
    include Traits::Authentication
    include Traits::Resource
    include Traits::Pagination
    include Traits::Actions::Create
    include Traits::Actions::Update
    include Traits::Actions::Destroy
    
    helper_method :q, :checkin, :checkout, :selected_days
    
    def features
        params[:features].values.delete_if(&:empty?) if q
    end

    def selected_days
        (checkout - checkin).to_i
    end

    def checkin
      q[:checkin].to_date || Date.today
    end
    
    def checkout
      q[:checkout].to_date || Date.today
    end

    def q
        params[:q]
    end
    
    def per_page
        5
    end

    def post_create_location
        estate_url(@estate)
    end

    def post_update_location
        estate_url(@estate)
    end
  
    def post_destroy_location
        estates_url
    end
    
    def resource_order_by
        params[:order_by] || :average_price
    end

    def resource_order
        params[:order] || :asc
    end
    
end
