class Post < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tags, through: :posts_tags
end
