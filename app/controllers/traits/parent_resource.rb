require File.dirname(__FILE__) + "/resource.rb"

module Traits::ParentResource
  
    def find_parent_resource 
        self.current_parent_resource = locate_parent_resource(parent_resource_param) || parent_resource_not_found!
    end
  
    def locate_parent_resource(id)
        parent_resource.find_by(parent_resource_attribute => id)
    end
  
    def parent_resource_attribute
        :id
    end
  
    def parent_resource_param
        params[:"#{parent_resource.name.downcase}_id"]
    end
  
    def parent_resource_not_found!
        raise Mongoid::Errors::DocumentNotFound.new(parent_resource, parent_resource_attribute => parent_resource_param)
    end
  
    def lookup_parent_resources
        parent_resource_scope.all :conditions => parent_resource_conditions
    end
  
    def parent_resource_conditions
        {}
    end

    def parent_resource_scope
        parent_resource
    end
  
    def self.included(kls)
        Traits::Resource.generate(kls, "parent_resource", 1)
    end
end








