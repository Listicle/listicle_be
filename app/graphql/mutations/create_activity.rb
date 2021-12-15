class Mutations::CreateActivity < Mutations::BaseMutation
  argument :project_id, ID, required: true
  argument :title, String, required: true
  argument :status, String, required: true

  field :activity, Types::ActivityType, null: false
  field :errors, [String], null: false

  def resolve(project_id:, title:, status:)
    activity = Activity.new(project_id: project_id, title: title, status: status)
    if activity.save!
      {
        activity: activity,
        errors: []
      }
    else
      {
        activity: nil,
        errors: activity.errors.full_messages
      }
    end
  end
end
