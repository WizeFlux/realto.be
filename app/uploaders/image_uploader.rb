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

    process :quality => 100

    version :lightbox do
        process :resize_to_limit => [800, 600]
        process :quality => 100
    end

    version :thumb do
        process :resize_to_fill => [290, 215]
        process :quality => 100
    end

    version :medium do
        process :resize_to_fill => [210, 145]
        process :quality => 100
    end

    version :nano do
        process :resize_to_fill => [130, 97]
        process :quality => 100
    end
end
