require 'rails_helper'

module Mutations
  module Tasks
    RSpec.describe UpdateTask,type: :request do
      describe '.resolve' do
        it "updates a new task" do
          user = create(:user)
          project = create(:project, user_id: user.id)
          activity = create(:activity, project_id: project.id)
          task = create(:task, activity_id: activity.id, task_name: 'task it', completed: false)

          post '/graphql', params: { query: query(id: task.id)}

          json = JSON.parse(response.body)
          data = json['data']['updateTask']['task']

          task.reload
          expect(task.completed).to eq(true)

          expect(Task.count).to eq(1)

        end

        it 'returns a task' do
          user = create(:user)
          project = create(:project, user_id: user.id)
          activity = create(:activity, project_id: project.id)
          task = create(:task, activity_id: activity.id, task_name: 'task it', completed: false)

          post '/graphql', params: { query: query(id: task.id)}

          json = JSON.parse(response.body)
          data = json['data']['updateTask']['task']
          task.reload

          expect(data['id']).to be_present
          expect(data['id']).to be_a String
          expect(data['taskName']).to be_a String
          expect(data['taskName']).to eq("task it")
          # expect(data['completed']).to be_a Boolean
          expect(data['completed']).to eq(true)
          expect(data['activityId']).to be_a Integer
          expect(data['activityId']).to eq(activity.id)
        end
      end

      def query(id:)
        <<~GQL
          mutation {
           updateTask(input: {
             id: #{id}
             completed: true
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
