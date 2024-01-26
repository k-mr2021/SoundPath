class Notification < ApplicationRecord
  
  belongs_to :user
  belongs_to :subject, polymorphic: true
  
  enum action_type: { commented_to_own_post: 0, favorited_to_own_post: 1, followed_me: 3}
  
end



