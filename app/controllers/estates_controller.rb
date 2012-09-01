class EstatesController < ApplicationController
    include Traits::Authentication
    include Traits::Resource
    include Traits::Actions::Create
    include Traits::Actions::Update
    include Traits::Actions::Destroy
    
    helper_method :q, :checkin, :checkout, :selected_days, :beds_from, :beds_to
    
    def features
        params[:features].values.delete_if(&:empty?) if (q && params[:features])
    end

    def selected_days
        (checkout.to_date - checkin.to_date).to_i
    end

    def beds_from
        q ? q[:beds_from].to_i : 0
    end
    
    def beds_to
        q ? q[:beds_to].to_i : 10
    end
    
    def checkin
        DateTime.parse((!q or q[:checkin].empty?) ? Date.today.to_s : q[:checkin])
    end
    
    def checkout
        DateTime.parse((!q or q[:checkout].empty?) ? Date.today.to_s : q[:checkout])
    end
    
    def q
        params[:q]
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
