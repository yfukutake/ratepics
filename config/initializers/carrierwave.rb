CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    # アクセスキー
    aws_access_key_id:     'AKIAJTXJDRZRKH55ZWNQ',
    # シークレットキー
    aws_secret_access_key: 'cSGP6WSVTxlqXlEl0oawTcfRXH//2uR47j6nST+v',
    # Tokyo
    region:                'ap-northeast-1',
  }
  
  config.cache_storage = :fog
  config.cache_dir = 'tmp/image-cache'
  
  case Rails.env
    when 'production'
      config.fog_directory = 'uploaded-pictures'
      config.asset_host = 'https://uploaded-pictures.s3-ap-northeast-1.amazonaws.com'

    when 'development'
      config.fog_directory = 'uploaded-pictures'
      config.asset_host = 'https://uploaded-pictures.s3-ap-northeast-1.amazonaws.com'

    when 'test'
      config.fog_directory = 'uploaded-pictures'
      config.asset_host = 'https://uploaded-pictures.s3-ap-northeast-1.amazonaws.com'
  end
  
end

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
