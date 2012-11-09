class AddHiddenToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :hidden, :boolean, default: false
  end
end
