class AddItemToImage < ActiveRecord::Migration
  def self.up
      add_attachment :images, :item
  end

  def self.down
    remove_attachment :images, :item
  end
end
