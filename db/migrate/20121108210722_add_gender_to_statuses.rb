class AddGenderToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :gender, :string
  end
end
