class Status < ActiveRecord::Base
  include ESpeak
  mount_uploader :audio, AudioUploader

  attr_accessible :gender, :message, :username

  validates :message, presence: true
  validates :gender, presence: true, inclusion: %w{male female}
  validates :username, presence: true

  after_create :write_mp3

  def male?
    gender == "male"
  end

  private

  def write_mp3
    variant = male? ? ["m1","m2","m3","m4","m5","m6","m7"].sample :  ["f1", "f2", "f3", "f4", "f5"].sample
    espeak("tmp/#{id}.mp3", text: message, voice: "en-sc+#{variant}") rescue nil
    self.audio = File.open("tmp/#{id}.mp3") if File.exists?("tmp/#{id}.mp3")
    save!
  end
end
