module ApplicationHelper
    def active_if(ways)
        'active' if ((ways.include? controller_name) || (ways.include? (controller_name + '#' + action_name)))
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
    
    def plus_one_button(url)
        render 'shared/plus_one', :url => url
    end
end