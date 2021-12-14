require 'rails_helper'

module Queries
  module Projects
    RSpec.describe 'query projects',type: :request do
      it "returns all projects" do
        tester = create(:user)
        proj1 = create(:project, user: tester)
        proj2 = create(:project, user: tester)
        act1 = create(:activity, project: proj1)
        act2 = create(:activity, project: proj1)
        act3 = create(:activity, project: proj2)

        def query(user_id:)
          <<~GQL
            query {
              projects {
              id
              projectName
              activitiesCount
              activities {
                id
                title
              }
            }
          }
          GQL
        end

        post '/graphql', params: { query: query(user_id: tester.id)}
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(json).not_to have_key('message')
        expect(json).to have_key('data')
        expect(json['data']).to be_a(Hash)
        expect(json['data']).to have_key('projects')
        expect(json['data']['projects']).to be_a(Array)
        expect(json['data']['projects'].size).to eq(2)

        result = json['data']['projects'].first

        expect(result.size).to eq(4)
        expect(result).to have_key('id')
        expect(result).to have_key('projectName')
        expect(result).to have_key('activitiesCount')
        expect(result['activitiesCount']).to eq(2)
        expect(result).to have_key('activities')
        expect(result['activities']).to be_a(Array)
        expect(result['activities'].size).to eq(2)
      end
    end
  end
end
