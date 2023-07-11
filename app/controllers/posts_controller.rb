class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]  #5/14修正
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]


  def index
    # @posts = Post.all
    @posts = Post.page(params[:page]).reverse_order  #この行を記述
    # @posts = Post.page(params[:page]).reverse_order 

  end

  # def show
  #   # @post = Post.find(params[:id])
  #   # @comment = Comment.new  #この行を追記
  #   # @comments = @post.comments.page(params[:page]).per(7).reverse_order  #この行を追記

  # end
  def show
    # この投稿についている全てのリアクションを取得します。
    @reactions = @post.reactions
  
    # 各リアクションの種類ごとに数をカウントします。
    @like_count = @reactions.where(reaction_type: 'like').count
    @thanks_count = @reactions.where(reaction_type: 'thanks').count
    @awesome_count = @reactions.where(reaction_type: 'awesome').count
  
    # 現在のユーザーがすでにつけたリアクションを取得します。
    @user_reactions = @reactions.where(user: current_user)
  
    # 現在のユーザーが各リアクションをすでにつけているかどうかを確認します。
    @user_has_liked = @user_reactions.where(reaction_type: 'like').exists?
    @user_has_thanked = @user_reactions.where(reaction_type: 'thanks').exists?
    @user_has_awesomed = @user_reactions.where(reaction_type: 'awesome').exists?
  end
  

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  # def update
  #   # post = Post.find(params[:id]) 5/14修正
  #   post.update(post_params)
  #   redirect_to post_path(post.id)
  # end

  def destroy
    # post = Post.find(params[:id]) 5/14この行を削除
    @post.destroy 
    redirect_to posts_path
  end

  def new
    @post = Post.new  
  end

  def create
    if current_user.admin?
      flash[:alert] = "管理者は投稿を作成できません。"
      redirect_to posts_path # redirect_to root_path 
    else
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to post_path(@post.id)
      else
        render :new
      end
    end
  end
  

  # def create
  #   @post = Post.new(post_params)
  #   @post.user_id = current_user.id
  #   if @post.save
  #    redirect_to post_path(@post.id)
  #   else
  #     render :new
  #   end
  # end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless current_user == @post.user 
      flash[:alert] = "この操作を実行する権限がありません。"
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:location, :text, :image)
  end
end
