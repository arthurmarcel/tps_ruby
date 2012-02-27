class AddUsername < ActiveRecord::Migration
  def up
    add_column :people, :username, :string
  end

  def down
    remove_column :people, :username
  end
end
