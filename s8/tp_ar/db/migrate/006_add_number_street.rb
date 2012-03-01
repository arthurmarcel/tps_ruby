class AddNumberStreet < ActiveRecord::Migration
  def up
    add_column :addresses, :number, :integer
    add_column :addresses, :street, :string
  end

  def down
    remove_column :addresses, :number
    remove_column :addresses, :street
  end
end
