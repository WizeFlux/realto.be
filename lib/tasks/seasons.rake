namespace :seasons do
    task :reprocess => :environment do |task, args|
        Estate.all.each do |estate|
            estate.pricelist.seasons.each do |season|
                if season.start && season.finish
                    season.datesranges.create({
                        :start => season.start,
                        :finish => season.finish
                    })
                end
            end
        end
    end
end
