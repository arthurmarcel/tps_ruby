class AddAddressId < ActiveRecord::Migration
  def up
    add_column :people, :address_id, :integer
  end

  def down
    remove_column :people, :address_id
  end
end
