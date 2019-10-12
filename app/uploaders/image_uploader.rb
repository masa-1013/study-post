class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fit: [255, 255]
  end

  def default_url(*args)
    "/images/" + [version_name, "default.png"].compact.join('_')
  end
end
