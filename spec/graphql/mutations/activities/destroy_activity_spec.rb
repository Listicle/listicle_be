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
        it 'returns the activity that was destroyed' do
          tester = create(:user)
          project = create(:project, user_id: tester.id)
          activity = create(:activity, project_id: project.id)
          post '/graphql', params: { query: query(id: activity.id)}
          json = JSON.parse(response.body)
          data = json['data']['destroyActivity']['activity']
          expect(data['title']).to eq(activity.title)
          expect(data['status']).to eq(activity.status)
          expect(data['id']).to eq(activity.id.to_s)
          expect(data['projectId']).to eq(activity.project_id)
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
