module ApplicationHelper
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
            :layout => :standart,
            :width => 300,
            :height => 35,
            :show_faces => false,
            :action => :like,
            :colorscheme => :light,
            :appId => Facebook::APP_ID.to_s
        )
        render 'shared/like', :url => url
    end
    
    def marker(symbol)
        "https://chart.googleapis.com/chart?chst=d_map_spin&chld=0.7|0|55bfe6|13|b|#{symbol}"
    end
    
    def plus_one_button(url)
        render 'shared/plus_one', :url => url
    end
end
