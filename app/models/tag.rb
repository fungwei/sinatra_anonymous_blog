class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts, through: :posts_tags
end
