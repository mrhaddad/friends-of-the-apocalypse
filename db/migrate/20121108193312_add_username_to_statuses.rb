class AddUsernameToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :username, :string
  end
end
