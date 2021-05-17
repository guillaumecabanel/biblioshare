module UserHelper
  def user_select(user)
    tag.div(user.initials, class: "user-avatar") + tag.div(user.full_name)
  end
end
