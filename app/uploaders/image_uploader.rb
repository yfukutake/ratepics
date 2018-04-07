class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  #include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  
  process resize_to_limit: [1200, 1000]
  process:convert => 'jpg'
  
  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :crop
    process :resize_to_fit => [700, 700]
  end

  def crop
    manipulate! do |img|
      gravity = Magick::CenterGravity # 中央から切り取ります。
      crop_w = img.columns
      crop_h = img.rows
      # 画像のサイズが縦横違った場合は小さい方に合わせてトリミングする。
      if img.rows <= img.columns
        crop_w = img.rows
      else
        crop_h = img.columns
      end
      img.crop!(gravity, crop_w, crop_h)
      img = yield(img) if block_given?
      img
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
  
  #def filename
  #  time = Time.now
  #  name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
  # name.downcase
  #end
  
  #def asset_host
  #  return "https://techacademy-yfukutake.c9users.io"
  #end
  #def asset_host
  #  return "https://localhost:8002"
  #end
  
  #def asset_host
  #  return " request.protocol + request.host_with_port "
  #end

  #def asset_host
  #  return " request.url "
  #end
  
end
