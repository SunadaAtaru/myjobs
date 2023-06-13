module UsersHelper

  # 引数で渡されたユーザーが現在のユーザーと同じかどうかを確認する
  def current_user?(user)
    user == current_user
  end
end
