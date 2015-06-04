class PostsController < ApplicationController
	authenticate_user!

	def new
		@capsule = Capsule.find(params[:capsule_id])
		@post = Post.new
	end

	def create
		@capsule = Capsule.find(params[:capsule_id])
  	@post = Post.new(params.require(:post).permit(:body, :title, :unique).merge(capsule_id: params[:capsule_id]))
		if @post.save
			redirect_to @capsule
			flash[:notice] = 'Post saved'
		else
			redirect_to @capsule
			flash[:login] = 'There was a problem with your post'
		end 
	end

	private

  def post_params
    (params.require(:post).permit(:title, :body, :unique).merge(capsule_id: params[:capsule_id]))
  end
end
