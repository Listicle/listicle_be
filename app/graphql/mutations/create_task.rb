class Mutations::CreateTask < Mutations::BaseMutation
  argument :task_name, String, required: true
  argument :completed, Boolean, required: true
  argument :activity_id, Integer, required: true

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(task_name:, completed:, activity_id:)
    task = Task.new(task_name: task_name, completed: completed, activity_id: activity_id)
        if task.save
      {
        task: task,
        errors: []
      }
    else
      {
        task: nil,
        errors: task.errors.full_messages
      }
    end
  end
end
