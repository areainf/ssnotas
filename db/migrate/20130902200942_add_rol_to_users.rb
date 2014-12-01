class AddRolToUsers < ActiveRecord::Migration
  def change
	 add_reference :users, :rol, index: true
  end
end
