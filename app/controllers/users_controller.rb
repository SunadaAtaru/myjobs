class UsersController < ApplicationController
  before_action :admin_user,     only: :destroy #12/24追記
  # before_action :correct_user, only: [:edit, :update]#1/1追記


  def index
    @users = User.page(params[:page]).per(2).reverse_order
  end

  # def show
  #   @user = User.find(params[:id])
  #   @posts = @user.posts.page(params[:page]).reverse_order

  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :profile_image)

  end

  # def correct_user
  #   redirect_to(root_url) unless current_user?(@user)
  # end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
