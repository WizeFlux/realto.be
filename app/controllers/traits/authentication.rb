module Traits::Authentication
    
    def signed_in?
        !!current_person
    end
    
    def current_person
        @current_person ||= authenticate_from_session! || authenticate_from_cookie!
    end
    
    def authenticate_from_session!
        Person.find(session[:person_id]) if session[:person_id]
    end
    
    def authenticate_from_cookie!
        Person.find(:first, :conditions => {:token => cookies[:token]}) if cookies[:token]
    end
    
    #
    # Facebook
    #
    
    def write_cookie_with_fb_person!
        write_cookie!(facebook_person) if fb_person_update_attributes
    end
    
    def facebook_person
        Person.find_or_create_by(:fb_uid => fb_person_respond['id'])
    end
    
    def graph
        @graph ||= Koala::Facebook::API.new(Koala::Facebook::OAuth.new(oauth_url(params[:redirect_id])).get_access_token(params[:code]))
    end
    
    def fb_person_respond
        @fb_person_respond ||= graph.get_object('me')
    end
    
    def oauth_url(id)
        facebook_session_url(:locale => nil, :redirect_id => id)
    end
    
    # def fb_person_picture_url
    #     @fb_person_picture ||= graph.get_picture('me')
    # end
    
    def fb_person_update_attributes
        facebook_person.update_attributes({
            :name => fb_person_respond['name'],
            :fb_uid => fb_person_respond['id'],
            :fb_url => fb_person_respond['link'],
            :email => fb_person_respond['email'],
            :password => fb_person_respond['email'].crypt(fb_person_respond['id']),
            # :avatar => Image.create(:remote_file_url => fb_person_picture_url)
        })
    end
    
    def create_person_by_facebook_respond
        Person.create(fb_person_attributes)
    end
    
    
    
    
    
    
    
    
    def ensure_person_is_authenticated!
        if signed_in?
            authenticated_person!
        else
            unauthenticated_person!
        end
    end
    
    def authenticated_person!
    end
    
    def unauthenticated_person!
        redirect_to new_session_url
    end
    
    def has_rights?
        case action_name
            
        when 'show'
            current_resource.able_to_show?(current_person)
            
        when 'index'
            able_to_index?(current_person)
            
        when 'new', 'create'
            current_resource.able_to_create?(current_person)
            
        when 'edit', 'update'
            current_resource.able_to_update?(current_person)
            
        when 'delete', 'destroy'
            current_resource.able_to_destroy?(current_person)
        end
    end
    
    def able_to_index?(referred)
        true
    end
    
    def ensure_person_has_rights!
        if has_rights?
            allowed_person!
        else
            permitted_person!
        end
    end
    
    def allowed_person!
    end
    
    def permitted_person!
        redirect_to current_resource
    end
    
    def write_cookie!(person)
        person.generate_token! rand
        person.save
        cookies[:token] = person.token
    end
    
    def write_session!(person)
        session[:person_id] = person.id
    end
    
    def clear_cookie!
        cookies.delete :token
    end
    
    def clear_session!
        session.delete :person_id
    end
end