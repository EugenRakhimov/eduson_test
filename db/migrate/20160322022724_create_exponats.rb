class CreateExponats < ActiveRecord::Migration
  def change
    create_table :exponats do |t|
      t.string :link
      t.integer :item_type

      t.timestamps null: false
    end
  end
end
