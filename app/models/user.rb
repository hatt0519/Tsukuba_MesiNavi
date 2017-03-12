class User < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:twitter, :facebook]

  def self.find_or_create_from_oauth(auth)
    user = where(uid: auth.uid, provider: auth.provider).first_or_create do |user|
      user.user_name = auth.info.name
      user.avatar_url = auth.info.image
    end
    if user.user_name != auth.info.name
      user.update(username: auth.info.name)
    end
    if user.avatar_url = auth.info.image
      user.update(avatar_url: auth.info.image)
    end
    return user
  end
end
