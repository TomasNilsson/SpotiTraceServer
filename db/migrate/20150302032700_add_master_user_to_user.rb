class AddMasterUserToUser < ActiveRecord::Migration
  def change
    add_reference :users, :master_user, index: true
  end
end
