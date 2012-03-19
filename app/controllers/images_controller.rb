class ImagesController < ApplicationController
    include Traits::Resource
    include Traits::Actions::Destroy
    include Traits::Actions::Create
        
    before_filter :find_resource, :only => %w[destroy]
    before_filter :new_resource, :only => %w[create]
    
    def resource_attributes
        {:image => params[:image][0]}
    end 

    def resource_create_success
        respond_to do |format|
          format.html {  
            render :json => [json_respond].to_json, :content_type => 'text/html', :layout => false
          }
          format.json {  
            render :json => [json_respond].to_json			
          }
          format.js {  
            render :json => [json_respond].to_json			
          }
        end
    end
    
    def json_respond
      {
        "name" => @image.image.filename,
        "size" => @image.image.size,
        "url" => @image.image.url,
        "html" => render_to_string(:layout => false, :partial => 'images/blob', :formats => [:html], :handlers => [:haml], :locals => {:image => @image}),
        "id" => @image.id
      }
    end
    
    def resource_create_failure
        head :error
    end
end
