class Status < ActiveRecord::Base
  include ESpeak

  attr_accessible :message, :username

  validates :message, presence: true

  after_create :write_mp3

  private

  def write_mp3
    espeak("#{id}.mp3", text: message)
    rescue
  end
end
