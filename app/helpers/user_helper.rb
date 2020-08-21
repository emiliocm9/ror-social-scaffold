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
      link_to 'Accept', friendship_path(user), method: :patch
      link_to 'Decline', friendship_path(user), method: :delete
    elsif current_user.pending_friends.include?(user)
        'You have sent a friend request' 
    else
        link_to 'friend request', friend_req_path(user)
    end    
  end

end