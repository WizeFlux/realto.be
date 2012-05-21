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
end

