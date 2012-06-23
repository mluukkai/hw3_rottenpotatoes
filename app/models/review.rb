class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  attr_protected :user_id # see text
end