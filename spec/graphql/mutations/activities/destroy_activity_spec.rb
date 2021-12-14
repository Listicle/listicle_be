require 'rails_helper'
module Mutations
  module Activities
    RSpec.describe DestroyActivity, type: :request do
      describe 'resolve' do
        it 'destroys a activity' do
          tester = create(:user)
          project = create(:project, user_id: tester.id)
          activity = create(:activity, project_id: project.id)


          post '/graphql', params: { query: query(id: activity.id)}
          json = JSON.parse(response.body)
          data = json['data']

          expect(Activity.count).to eq(0)
        end
      end
      def query(id:)
    <<~GQL
    mutation{
      destroyActivity(input: {
         id: #{id},
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
