class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :activities, through: :projects
  has_many :tasks, through: :activities

  validates_presence_of :username
  validates_uniqueness_of :username
end
