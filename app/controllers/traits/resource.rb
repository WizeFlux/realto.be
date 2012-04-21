module Traits::Resource
  
  def find_resource
    self.current_resource = locate_resource(resource_param) || resource_not_found!
  end
  
  def locate_resource(id)
    resource_scope.find :first, :conditions => {resource_attribute => id}
  end
  
  def resource_attribute
    :id
  end
  
  def resource_param
    params[:id]
  end
  
  def find_resources
    self.current_resources = lookup_resources
  end
  
  def resource_conditions
    {}
  end
  
  def resource_sort_conditions
    [[resource_order_by, resource_order]]
  end
  
  def resource_order_by
    params[:order_by]
  end
  
  def resource_order
    params[:order]
  end
  
  def resource_not_found!
    raise Mongoid::Errors::DocumentNotFound.new(resource, resource_attribute => resource_param)
  end
  
  def lookup_resources
    resource_scope.all :conditions => resource_conditions.delete_if{|key, value| value.blank?}, :sort => resource_sort_conditions
  end
  
  def resource_scope
    resource
  end
  
  def self.included(kls)
    generate(kls)
  end
  
  def self.generate(kls, type = "resource", position = 0)
    method = "#{type}_name"
    name = kls.send(method) if (kls.respond_to?(method))
    name = kls.name.tableize.split("_")[ - position - 2 ].singularize unless name
    kls.module_eval %{
      def #{type}
        #{name.capitalize}
      end

      def #{type}_attributes
        params[:#{name}]
      end

      def current_#{type}
        @#{name}
      end
      
      def current_#{type}=(arg)
        @#{name} = arg
      end
      
      def current_#{type.pluralize}
        @#{name.pluralize}
      end
      
      def current_#{type.pluralize}=(arg)
        @#{name.pluralize} = arg
      end}
  end
end