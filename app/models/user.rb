class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.find_or_create_from_oauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    
    if user.new_record?
      user.email = auth.info.email
      user.name = auth.info.name
      user.save!
    end
    
    user
  end
end


