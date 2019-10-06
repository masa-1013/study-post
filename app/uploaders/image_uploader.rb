class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  process resize_to_fit: [800, 800]

  version :thumb do
    process resize_to_fit: [280, 300]
  end

  version :thumbIcon do
    process resize_to_fit: [85, 85]
  end

  version :thumbIconSmall do
    process resize_to_fit: [60, 60]
  end

  def default_url(*args)
    "/images/" + [version_name, "default.png"].compact.join('_')
  end
end
