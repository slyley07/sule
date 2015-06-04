class CapsulesController < ApplicationController
	before_action :set_capsule, only:[:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except:[:show]

	def index
		@capsules = current_user.capsules
	end

	def new
		@user = current_user
		@capsule = Capsule.new
	end

	def new
		@capsule = Capsule.new
	end

	def show
		@new_user = User.new
		release = @capsule.release_date.to_datetime
		reday = release.day
		remonth = release.month
		reyear = release.year
		date = Time.now
		day = date.day
		month = date.month
		year = date.year
		@year_remaining =  reyear - year 
		@month_remaining = remonth - month 
		@day_remaining = reday - day
		@post = Post.new
	end

	def edit
		@post = Post.new
		# @image = ImageUploader.new
	end

	def delete
		@capsules = current_user.capsules
	end

	def create
		@user = current_user
		@capsule = Capsule.new(params.require(:capsule).permit(:title, :release_date).merge(user: current_user))
		if @capsule.save
			redirect_to @capsule, notice: "New capsule created!"
		else
			render :index
		end
	end

	def update
		if @capsule.update(params.require(:capsule).permit(:post, :video, :image))
			redirect_to capsules_path, notice: "Your capsule has been updated"
		else
			render :edit
		end
	end

	def destroy
		if @capsule.destroy
			redirect_to current_user.capsules
		else
			redirect_to capsules_remove_path, notice: "There was a problem deleting this capsule"
		end
	end

	private

	def set_capsule
		@capsule = Capsule.find(params[:id])
	end

	def set_new_user
		@new_user = User.new
	end
end
