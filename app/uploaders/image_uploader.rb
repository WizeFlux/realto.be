# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    storage :file

    def extension_white_list
        %w(jpg jpeg gif png)
    end

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    version :lightbox do
      process :resize_to_fill => [800, 600]
    end

    version :thumb do
      process :resize_to_fill => [290, 215]
    end

    version :medium do
      process :resize_to_fill => [210, 145]
    end

    version :nano do
      process :resize_to_fill => [130, 97]
    end
end
