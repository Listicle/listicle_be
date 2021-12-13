require 'rails_helper'
module Mutations
  module Activities
    RSpec.describe UpdateActivity, type: :request do
      before(:each) do
        @tester = create(:user)
        @project = create(:project, user_id: @tester.id)
        @activity1 = create(:activity, project_id: @project.id, title: 'task', status: 'doing')
        @activity2 = create(:activity, project_id: @project.id)
      end
      describe 'resolve' do
        it 'updates an activity' do
          post '/graphql', params: {query: query(id: @activity1.id)}
          json = JSON.parse(response.body)
          data = json['data']['updateActivity']['activity']
          @activity1.reload
          expect(@activity1.status).to eq('done')
        end
      end
      def query(id:)
        <<~GQL
        mutation{
          updateActivity(input: {
             id: #{id},
            status: done
          })
          {
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
