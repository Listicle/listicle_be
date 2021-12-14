require 'rails_helper'

module Mutations
  module Activities
    RSpec.describe CreateActivity, type: :request do
      describe 'resolve' do
        it 'creates a new activity' do
          tester = create(:user)
          project = create(:project, user_id: tester.id)

          post '/graphql', params: { query: query(project_id: project.id)}
          json = JSON.parse(response.body)
          data = json['data']['createActivity']

          expect(Activity.count).to eq(1)
        end
      end
      def query(project_id:)
    <<~GQL
    mutation{
      createActivity(input: {
         projectId: #{project_id},
         title: "create a task",
        status: to_do
            }) {
          activity {
            title,
            status,
            id,
            projectId
          }
          errors
        }
      }
      GQL
      end
    end
  end
end
