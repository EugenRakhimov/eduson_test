class AddUserRefToExponats < ActiveRecord::Migration
  def change
    add_reference :exponats, :user, index: true, foreign_key: true
  end
end