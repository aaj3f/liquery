class AddAdminAccessToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin_access, :boolean, default: false
  end
end
