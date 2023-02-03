class User < ApplicationRecord
  include GenerateCsv
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :likes
  
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:user) if self.roles.blank?
    self.add_role(:active)
  end
end
