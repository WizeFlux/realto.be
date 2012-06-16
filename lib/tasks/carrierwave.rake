# CarrierWave rake tasks
#
# Task:   reprocess
# Desc:   Reprocess all images for a given class
# Usage:  rake carrierwave:reprocess class=<ClassName> mount_uploader=<mount_uploader>

namespace :carrierwave do
    task :reprocess => :environment do |task, args|
        Image.all.each do |image|
            image.image.recreate_versions!
        end
    end
    
    task :clear => :environment do |task, args|
        ids_in_use = []
        ids_to_delete = []
        
        Agency.all.each do |agency|
            agency.booklets.each do |booklet|
                ids_in_use += booklet.images.collect(&:id)
            end
        end
        
        Estate.all.each do |estate|
            estate.booklets.each do |booklet|
                ids_in_use += booklet.images.collect(&:id)
            end
        end
        
        ids_to_delete = Image.not_in(:_id => ids_in_use).to_a
        p "#{ids_in_use.size} images used"
        p "#{ids_to_delete.size} images deleted"
        ids_to_delete.each(&:delete)
        
        storage = Rails.root.join('public/uploads/image/image')
        ids_in_use.map!(&:to_s)
        
        storage.children.each do |f|
            if ids_in_use.include?(f.basename.to_s)
                FileUtils.rm_rf f.to_s
                print '.'
            end
        end
        print " ok\n"
        p "#{ids_in_use.size} images used"
        p "#{ids_to_delete.size} images deleted"
    end
    
end

