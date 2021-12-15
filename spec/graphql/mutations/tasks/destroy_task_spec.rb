require 'rails_helper'

module Mutations
  module Tasks
    RSpec.describe DestroyTask, type: :request do
      before(:each) do
        @user = create(:user)
        @project = create(:project, user_id: @user.id)
        @activity = create(:activity, project_id: @project.id)
        @task = create(:task, activity_id: @activity.id)
      end

      describe '.resolve' do
        it 'removes a task' do
            post '/graphql', params: { query: query(id: @task.id, activity_id: @activity.id) }
            json = JSON.parse(response.body)
            data = json['data']

          expect(Task.count).to eq(0)
        end

        it 'returns a task' do
          post '/graphql', params: { query: query(id: @task.id, activity_id: @activity.id) }
          json = JSON.parse(response.body)
          data = json['data']['destroyTask']['task']

          expect(data).to include(
            'id'              => "#{@task.id}",
            'taskName'        => @task.task_name,
            'completed'       => @task.completed,
            'activityId'      => @activity.id
          )
        end
      end

      def query(id:, activity_id:)
        <<~GQL
        mutation {
          destroyTask(input: {
           id: #{id},
           activityId: #{activity_id}
          }) {
           task {
             id,
             taskName,
             completed,
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
