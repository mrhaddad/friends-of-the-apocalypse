class AddAudioToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :audio, :string
  end
end
