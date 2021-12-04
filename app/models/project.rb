class Project < ApplicationRecord
  belongs_to :user

  has_many :activities, dependent: :destroy
  has_many :tasks, through: :activities

  validates_presence_of :project_name
end
