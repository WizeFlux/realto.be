module Traits::Pagination
  
  def self.resource_paginated?
    true
  end

  def lookup_resources
    super.page(current_page).per(per_page).all
  end
  
  def per_page
    25
  end
  
  def current_page
    params[:page]
  end

end
