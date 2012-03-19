require File.dirname(__FILE__) + "/resource.rb"

module Traits::SubdomainResource
    def find_subdomain_resource 
      self.current_subdomain_resource = locate_subdomain_resource(subdomain_resource_param) || subdomain_resource_not_found!
    end
  
    def locate_subdomain_resource(id)
      subdomain_resource.find :first, :conditions => {subdomain_resource_attribute => id}
    end
  
    def subdomain_resource_attribute
      :id
    end
  
    def subdomain_resource_param
      params[:id]
    end
    
    def subdomain_resource_not_found!
      raise Mongoid::Errors::DocumentNotFound.new(subdomain_resource, subdomain_resource_attribute => subdomain_resource_param)
    end
  
    def subdomain_resource_scope
      subdomain_resource
    end
  
    def self.included(kls)
      Traits::Resource.generate(kls, "subdomain_resource", 1)
    end
end








