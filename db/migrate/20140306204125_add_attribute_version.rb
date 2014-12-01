class AddAttributeVersion < ActiveRecord::Migration
  def change
    add_column :versions, :ip, :string
    add_column :versions, :user_agent, :string 
    add_column :versions, :user_id, :integer
  end
  def down
    change_table :versions do |t|
	t.remove  :ip
	t.remove  :user_agent
	t.remove  :user_id
	
   end
 end
end
