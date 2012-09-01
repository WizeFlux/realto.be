class SessionsController < ApplicationController
    include Traits::Resource
    include Traits::Actions::Create
    include Traits::Actions::Destroy
    
    helper_method :attempted_signin?
    
    def resource_create
        @person = Person.find_by(resource_attributes.slice(:email, :password))
    end
    
    def attempted_signin?
        resource_attributes
    end
    
    def remember_me?
        !!resource_attributes[:remember_me]
    end
    
    def facebook
        write_cookie_with_fb_person!
        redirect_to post_create_location
    end
    
    def resource_create_success
        remember_me? ? write_cookie!(@person) : write_session!(@person)
        redirect_to post_create_location
    end
    
    def post_create_location
        params[:redirect_id] ? Redirect.find(params[:redirect_id]).url : root_url
    end
    
    def resource_destroy_success
        redirect_to post_create_location
    end
    
    def resource_destroy
        clear_cookie!
        clear_session!
        return true
    end
end