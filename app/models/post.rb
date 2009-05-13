class Post < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title, :matter
	validates_uniqueness_of :title
	has_attached_file :photo,
	    :styles => {
      :thumb	=> "10x10#",
      :small  => "50x50>" }
end
