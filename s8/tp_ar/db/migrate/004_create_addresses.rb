class CreateAddresses < ActiveRecord::Migration
  def up
    create_table :addresses do |t|
    end
  end

  def down
    drop_table :addresses
  end
end
