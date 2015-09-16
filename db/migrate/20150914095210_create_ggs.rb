class CreateGgs < ActiveRecord::Migration
  def change
    create_table :ggs do |t|
      t.string :gname
      t.string :leader
      t.integer :account_number
      t.integer :total
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
