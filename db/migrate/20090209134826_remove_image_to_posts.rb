class RemoveImageToPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :Image
  end

  def self.down
    add_column :posts, :Image, :string
  end
end
