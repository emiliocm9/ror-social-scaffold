module UserHelper
  def friend_check(user)
    if current_user.friend?(user)
      'is your friend!'
    elsif current_user == user
      'You are the same person'
    else
      friend_change(user)
    end
  end

  def friend_change(user)
    if current_user.friend_requests.include?(user)
      ('<p><button>' + (link_to 'Decline', friendship_path(user), method: :delete) + '</button><p>').html_safe
    elsif current_user.pending_friends.include?(user)
      'You have sent a friend request'
    else
      ('<p><button>' + (link_to 'friend request', friend_req_path(user)) + '</button><p>').html_safe
    end
  end

  def friend_acc(user)
    if current_user.friend_requests.include?(user)
      ('<p><button>' + (link_to 'Accept', friendship_path(user), method: :patch) + '</button><p>').html_safe
    else
      '<p><p>'.html_safe
    end
  end
end
