class Contact
    include Mongoid::Document
    include Mongoid::I18n

    field :kind, type: String
    field :entry, type: String
    
    def self.kinds
        ['Skype', 'Email', 'Facebook', 'Phone']
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
