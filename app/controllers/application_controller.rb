class ApplicationController < ActionController::Base
    include Traits::Authentication
    layout proc{ |c| c.request.xhr? ? false : "application" }
    protect_from_forgery
    
    before_filter :set_locale

    def agency_param_from_domain
        request.subdomain.blank? ? request.domain.split('.').first : request.subdomain
    end

    def current_agency
        @current_agency ||= Agency.find(agency_param_from_domain)
    end
    
    def this_page_redirect
        @current_redirect ||= Redirect.find_or_create_by(url: request.url)
    end
    
    def default_url_options(options={})
        {:locale => I18n.locale}
    end

    def set_locale
        I18n.locale = params[:locale] || current_agency.default_language || I18n.default_locale
    end

    def editable?
        signed_in? && current_resource.able_to_update?(current_person)
    end
    
    helper_method   :signed_in?, :current_person, :agency_param_from_domain, :current_agency,
                    :oauth_url, :this_page_redirect, :editable?, :current_parent_resourcem, :current_resource
end
