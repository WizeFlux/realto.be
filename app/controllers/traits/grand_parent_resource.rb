require File.dirname(__FILE__) + "/parent_resource.rb"
require File.dirname(__FILE__) + "/resource.rb"

module Traits
  module GrandParentResource
    
    def find_grand_parent_resource 
      self.current_grand_parent_resource = locate_grand_parent_resource(grand_parent_resource_param) || grand_parent_resource_not_found!
    end
  
    def locate_grand_parent_resource(id)
      grand_parent_resource.find :first, :conditions => {grand_parent_resource_attribute => id}
    end
  
    def grand_parent_resource_attribute
      :id
    end
  
    def grand_parent_resource_param
      params[:id]
    end
  
    def find_grand_parent_resources
      self.current_grand_parent_resources = lookup_grand_parent_resources
    end
  
    def grand_parent_resource_not_found!
      raise Mongoid::Errors::DocumentNotFound.new(grand_parent_resource, grand_parent_resource_attribute => grand_parent_resource_param)
    end
  
    def lookup_grand_parent_resources
      grand_parent_resource_scope.all :conditions => grand_parent_resource_conditions
    end
  
    def grand_parent_resource_conditions
      {}
    end

    def grand_parent_resource_scope
      grand_parent_resource
    end
  
    def self.included(kls)
      Traits::Resource.generate(kls, "grand_parent_resource", 2)
    end
  end
end
