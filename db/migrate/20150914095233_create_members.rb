class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :tname
      t.integer :gg_id
      t.integer :tnumber
      t.timestamps null: false
    end
  end
end
