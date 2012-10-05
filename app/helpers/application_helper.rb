module ApplicationHelper

    def log!(item)
        logger.info "==> -=##{item.class}#=- #{item.inspect}"
    end
    
    def bs_i18n_text_area(f, method, title, options = {})
        bs_i18n_text_wrapper(f, method, title, options) do |ff, flng, ftitle, foptions, parent_f|
            bs_text_area ff, flng, ftitle, foptions, parent_f, method
        end
    end
    
    def bs_i18n_text_field(f, method, title, options = {})
        bs_i18n_text_wrapper(f, method, title, options) do |ff, flng, ftitle, foptions, parent_f|
            bs_text_field ff, flng, ftitle, foptions, parent_f, method
        end
    end
    
    def avaiable_languages
      current_agency.operating_languages
    end
    
    def bs_i18n_text_wrapper(f, method, title, options = {}, &block)
        f.fields_for (method.to_s + '_translations') do |ff|
            fields = avaiable_languages.collect do |lng|
                if !f.object.new_record? and f.object.send(method.to_s + '_translations') and f.object.send(method.to_s + '_translations')[lng]
                    options.merge!({:value => (f.object.send(method.to_s + '_translations')[lng])})
                end
                yield(ff, lng, (title + " (#{lng})"), options, f)
            end
            raw(fields.join)
        end
    end

    def bs_text_area(f, method, title, options = {}, parent_f = nil, parent_method = nil)
        bs_wrapper(f, method, title, parent_f, parent_method) do
            f.text_area method, options
        end
    end
    
    def bs_text_field(f, method, title, options = {}, parent_f = nil, parent_method = nil) 
        bs_wrapper(f, method, title, parent_f, parent_method) do
            f.text_field method, options
        end
    end
    
    def bs_wrapper(f, method, title, parent_f = nil, parent_method = nil, &block)
        klass = 'control-group'
        # debugger
        if (parent_f and parent_f.object.errors.has_key?(parent_method)) or (f.object and f.object.errors.has_key?(method))
          klass += ' error'
        end
        
        content_tag :div, :class => klass do
            f.label(method, title, :class => 'control-label') + content_tag(:div, capture(&block), :class => 'controls')
        end
    end
    
    def active_if(ways, condition)
        'active' if (condition ||
                    (ways.include? controller_name) ||
                    (ways.include? (controller_name + '#' + action_name)) ||
                    (ways.include? (controller_name + '#' + action_name + '#' + current_resource.id.to_s) if current_resource))
    end
    
    def like_button(page)
        url = root_url(
            :host => 'www.facebook.com/plugins/like.php',
            :port => nil,
            :locale => nil,
            :href => page,
            :send => false,
            :layout => :standard,
            :width => 300,
            :height => 35,
            :show_faces => false,
            :action => :like,
            :colorscheme => :light#,
            # :appId => Facebook::APP_ID.to_s
        )
        render 'shared/like', :url => url
    end
    
    def marker(symbol, color, size, rotation)
        "https://chart.googleapis.com/chart?chst=d_map_spin&chld=#{size.to_s}|#{rotation.to_s}|#{color}|13|b|#{symbol}"
    end

    def plus_one_button(url)
        render 'shared/plus_one', :url => url
    end
end
