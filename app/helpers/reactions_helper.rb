module ReactionsHelper
  def reaction_icon(type)
    case type
    when "like"
      "fa-thumbs-up"
    when "thanks"
      "fa-handshake"
    when "awesome"
      "fa-star"
    else
      "fa-question" # デフォルトのアイコン
    end
  end
end
