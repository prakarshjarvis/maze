class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  has_many :likes
  has_one_attached :image, :dependent => :destroy
end
