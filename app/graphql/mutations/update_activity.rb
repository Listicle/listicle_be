class Mutations::UpdateActivity < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :title, String, required: false
  argument :status, Types::Status, required: false

  field :activity, Types::ActivityType, null: false
  field :errors, [String], null: false

  def resolve(id:, **args)
    activity = Activity.find(id)
    if activity.update!(args)
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
