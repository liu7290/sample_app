class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :user, :email, :unique => true
  end

  def self.down
    emove_index :user, :email
  end
end
