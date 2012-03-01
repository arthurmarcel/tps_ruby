class CreateChildren < ActiveRecord::Migration
  def up
    create_table :children do |t|
    end
  end

  def down
    drop_table :children
  end
end
