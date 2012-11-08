class Status < ActiveRecord::Base
  include ESpeak
  mount_uploader :audio, AudioUploader

  attr_accessible :message, :username

  validates :message, presence: true

  after_create :write_mp3

  private

  def write_mp3
    variant = ["m1","m2","m3","m4","m5","m6","m7", "f1", "f2", "f3", "f4", "f5"].sample
    espeak("tmp/#{id}.mp3", text: message, voice: "en+#{variant}") rescue nil
    self.audio = File.open("tmp/#{id}.mp3") if File.exists?("tmp/#{id}.mp3")
    save!
  end
end
