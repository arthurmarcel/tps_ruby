class AddNamePersonId < ActiveRecord::Migration
  def up
    add_column :children, :name, :string
    add_column :children, :person_id, :integer
  end

  def down
    remove_column :children, :name
    remove_column :children, :person_id
  end
end
