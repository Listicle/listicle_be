class Mutations::DestroyActivity < Mutations::BaseMutation
  argument :id, Integer, required: true

  field :activity, Types::ActivityType, null: false
  field :errors, [String], null: false

  def resolve(id:)
    activity = Activity.find(id)
        if activity.destroy
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
