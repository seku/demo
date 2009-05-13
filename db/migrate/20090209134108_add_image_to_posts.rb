class AddImageToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :Image, :string
  end

  def self.down
    remove_column :posts, :Image
  end
end
