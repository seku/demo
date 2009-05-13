class ImagesController < ApplicationController
	def destroy
		@post = Post.find(params[:post_id])
		@post.photo = nil
		@post.save
		redirect_to edit_post_path(@post)
	end 
end
