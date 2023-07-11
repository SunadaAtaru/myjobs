# class FavoritesController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_post, only: [:create, :destroy]
  
  
#   def destroy
#     # @post = Post.find(params[:post_id])
#     favorite = current_user.favorites.find_by(post_id: @post.id)
#     favorite.destroy
#     # redirect_to post_path(post) #この行を削除
#   end
  
#   def create
#     # @post = Post.find(params[:post_id])
#     favorite = current_user.favorites.new(post_id: @post.id)
#     favorite.save
#     # redirect_to post_path(post) #この行を削除
#   end

#   private

#   def set_post
#     @post = Post.find(params[:post_id])
#   end
  
# end
