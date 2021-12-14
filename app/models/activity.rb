class Activity < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy

  validates_presence_of :title
  validates_presence_of :status
  # validates_numericality_of :status

  enum status: [:to_do, :doing, :done]
end
