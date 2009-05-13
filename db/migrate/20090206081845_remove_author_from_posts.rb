class RemoveAuthorFromPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :author
  end

  def self.down
    add_column :posts, :author, :string
  end
end
