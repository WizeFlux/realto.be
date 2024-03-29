class Contact
    include Mongoid::Document

    field :kind, type: String
    field :entry, type: String
    
    def self.kinds
        ['Skype', 'Email', 'Facebook', 'Phone', 'Website']
    end

    def text
        case kind
            when 'Email' 
                entry
            when 'Skype'
                entry
			when 'Facebook'
			    I18n.t('views.interface.facebook_group')
		    when 'Phone'
                entry
        end
    end
    
    def href
        case kind
            when 'Email' 
                'mailto:' + entry
            when 'Skype'
                'skype:' + entry + '?call'
			when 'Facebook'
			    'http://' + entry
		    when 'Phone'
                'callto://' + entry
        end
    end
    
    embedded_in :contactable, polymorphic: true
end
