class AddFacebookExistsToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :facebook_exists, :boolean, default: true
  end
end
