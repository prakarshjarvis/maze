class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  has_many :likes, as: :likeable
  has_one_attached :image, :dependent => :destroy
  include PostsCsv
  # default_scope { where(published: false) }
end
