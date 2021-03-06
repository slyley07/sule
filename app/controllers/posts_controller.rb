class PostsController < ApplicationController

	before_action :authenticate_user!

	before_action :set_new_user


	def new
		@capsule = Capsule.find(params[:capsule_id])
		@post = Post.new
	end

	def create
		@capsule = Capsule.find(params[:capsule_id])
  	@post = Post.new(params.require(:post).permit(:body, :title ).merge(capsule_id: params[:capsule_id]))
		if @post.save
			redirect_to @capsule
			flash[:notice] = 'Your memory has been stored in this capsule'
		else
			redirect_to @capsule
			flash[:login] = 'There was a problem with saving your memory'
		end 
	end

	private

  def post_params
    (params.require(:post).permit(:title, :body).merge(capsule_id: params[:capsule_id]))
  end

  def set_new_user
		@new_user = User.new
	end
end
