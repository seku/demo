class User < ActiveRecord::Base
	has_many :posts	
	acts_as_authentic
	has_attached_file :photo,
	    :styles => {
      :thumb	=> "10x10#",
      :small  => "50x50>" }
	
end
