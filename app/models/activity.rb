class Activity < ApplicationRecord
  belongs_to :project
  has_many :tasks, dependent: :destroy

  validates_presence_of :title
  validates_inclusion_of :completed, in: ["future", "current", "completed"]

  # validates_presence_of :status
  # enum status: [:future, :current, :completed]

  # validates_numericality_of :status ##OLD
  # enum status: [:to_do, :doing, :done]  ##OLD
end
