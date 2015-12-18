class AddSessionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session, :boolean, default: false
  end
end
