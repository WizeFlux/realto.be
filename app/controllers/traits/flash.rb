module Traits::Flash 
  
  def notify_on_successful_create
    flash[:success] = "#{resource_name.humanize} was successfuly created"
  end
  
  def notify_on_failed_create
    flash[:error] = "#{resource_name.humanize} was failed to create"
  end
  
  def notify_on_destroy
    flash[:notice] = "#{resource_name} was deleted"
  end
  
end