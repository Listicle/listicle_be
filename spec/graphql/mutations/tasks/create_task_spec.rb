require 'rails_helper'

module Mutations
  module Tasks
    RSpec.describe CreateTask,type: :request do
      describe '.resolve' do
        it "creates a new task" do
          user = create(:user)
          project = create(:project, user_id: user.id)
          activity = create(:activity, project_id: project.id)

          post '/graphql', params: { query: query(activity_id: activity.id)}

          json = JSON.parse(response.body)
          data = json['data']['createTask']

          expect(Task.count).to eq(1)
        end

        it 'returns a task' do
          user = create(:user)
          project = create(:project, user_id: user.id)
          activity = create(:activity, project_id: project.id)

          post '/graphql', params: { query: query(activity_id: activity.id)}

          json = JSON.parse(response.body)
          data = json['data']['createTask']['task']

          expect(data['id']).to be_present
          expect(data['id']).to be_a String
          expect(data['taskName']).to be_a String
          expect(data['taskName']).to eq("New boot goofin")
          # expect(data['completed']).to be_a Boolean
          expect(data['completed']).to eq(false)
          expect(data['activityId']).to be_a Integer
          expect(data['activityId']).to eq(activity.id)
        end
      end

      def query(activity_id:)
        <<~GQL
          mutation {
           createTask(input: {
             completed: false
             taskName: "New boot goofin"
             activityId: #{activity_id}
           }) {
             task {
               id
               taskName
               completed
               activityId
             }
             errors
           }
          }
        GQL
      end
    end
  end
end
