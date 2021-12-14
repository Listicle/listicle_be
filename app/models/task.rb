class Task < ApplicationRecord
  belongs_to :activity

  validates_presence_of :task_name
  validates_inclusion_of :completed, in: [true, false]
end
