class Status < ActiveRecord::Base
  include ESpeak
  mount_uploader :audio, AudioUploader

  attr_accessible :gender, :message, :username

  validates :message, presence: true
  validates :gender, presence: true, inclusion: %w{male female}
  validates :username, presence: true

  before_create :set_facebook_exists
  after_create :write_mp3

  scope :visible, where("hidden != true")

  def male?
    gender == "male"
  end

  private

  def set_facebook_exists
    response = Nestful.get("https://graph.facebook.com/#{username}", format: :json) rescue nil
    self.facebook_exists = response.present?
    true
  end

  def write_mp3
    variant = male? ? ["m1","m2","m3","m4","m5","m6","m7"].sample :  ["f1", "f2", "f3", "f4", "f5"].sample
    espeak("tmp/#{id}.mp3", text: message, voice: "en-sc+#{variant}") rescue nil
    self.audio = File.open("tmp/#{id}.mp3") if File.exists?("tmp/#{id}.mp3")
    save!
  end
end
