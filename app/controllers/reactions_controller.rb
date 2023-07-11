class ReactionsController < ApplicationController

  before_action :set_post, only: [:create, :destroy]
 
  # 現在ログインしているユーザーに紐づいた新しいリアクションを作成します。
  # リアクションは指定された投稿とリアクションのタイプ（'like'、'thanks'、'awesome'等）に関連付けられます。
  def create
   reaction = current_user.reactions.new(post_id: @post.id, reaction_type: params[:reaction_type])

   reaction.save

  # クライアントへのレスポンスはJavaScript形式です。これにより、
  # 対応する.js.erbビューファイルがレンダリングされ、Ajaxを通じてブラウザに送信されます。
   respond_to do |format|
     format.js
   end
  end

  def destroy
   # 現在のユーザーが既に与えている指定の投稿とリアクションタイプに関連付けられたリアクションを探します。
   reaction = current_user.reactions.find_by(post_id: @post.id, reaction_type: params[:reaction_type])
   if reaction.present?
    # そのリアクションをデータベースから削除します。
    reaction.destroy
   else
    # reactionが存在しない場合の処理をここに書く。
    # 例えば、エラーメッセージをログに書き出す、など。
    Rails.logger.error "Reaction not found: user_id=#{current_user.id}, post_id=#{@post.id}, reaction_type=#{params[:reaction_type]}"
   end 
   # クライアントへのレスポンスはJavaScript形式です。これにより、
   # 対応する.js.erbビューファイルがレンダリングされ、Ajaxを通じてブラウザに送信されます。
    respond_to do |format|
      format.js
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

end
