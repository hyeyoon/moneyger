class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :date
      t.string :content
      t.integer :howmuch
      t.integer :remain
      t.string :board_type  # CHOICES : ['GROUP', 'ONLY']
      t.integer :gg_id
      t.integer :member_id  # only 
      t.timestamps null: false
    end
  end
end
