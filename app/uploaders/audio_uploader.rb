# encoding: utf-8

class AudioUploader < CarrierWave::Uploader::Base
  storage :file
end
