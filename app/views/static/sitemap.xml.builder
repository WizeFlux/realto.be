xml.instruct!
xml.urlset do
  current_agency.operating_languages.each do |language|
    
    current_agency.booklets.each do |booklet|
      xml.url do
        xml.loc agency_booklet_url(booklet, :locale => language)
        xml.changefreq 'weekly'
        xml.priority '1'
      end      
    end
    
    current_agency.estates.each do |estate|
      xml.url do
        xml.loc estate_url(estate, :locale => language)
        xml.changefreq 'weekly'
        xml.priority '1'
      end
      
      estate.booklets.each do |booklet|
        xml.url do
          xml.loc estate_booklet_url(estate, booklet, :locale => language)
          xml.changefreq 'weekly'
          xml.priority '1'
        end
      end
    end
    
  end
end