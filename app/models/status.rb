class Status < ActiveRecord::Base
  include ESpeak
  mount_uploader :audio, AudioUploader

  attr_accessible :message, :username

  validates :message, presence: true

  after_create :write_mp3

  private

  def write_mp3
    espeak("tmp/#{id}.mp3", text: message) rescue nil
    self.audio = File.open("tmp/#{id}.mp3") if File.exists?("tmp/#{id}.mp3")
    save!
  end
end
