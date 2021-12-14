require 'rails_helper'

module Queries
  module Projects
    RSpec.describe 'query projects',type: :request do
      it "returns one project" do
        tester1 = create(:user)
        tester2 = create(:user)
        proj1 = create(:project, user: tester1)
        proj2 = create(:project, user: tester2)
        act1 = create(:activity, project: proj1)
        act2 = create(:activity, project: proj1)
        act3 = create(:activity, project: proj2)

        def query(id:,user_id:)
          <<~GQL
            query {
              project(id:#{id}) {
              id
              userId
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

        post '/graphql', params: { query: query(id: proj1.id, user_id: tester1.id)}
        json = JSON.parse(response.body)
        # binding.pry

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(json).not_to have_key('message')
        expect(json).to have_key('data')
        expect(json['data']).to be_a(Hash)
        expect(json['data']).to have_key('project')
        expect(json['data']['project']).to be_a(Hash)

        result = json['data']['project']

        expect(result.size).to eq(5)
        expect(result).to have_key('id')
        expect(result['id'].to_i).to eq(proj1.id)

        expect(result).to have_key('userId')
        expect(result['userId'].to_i).to eq(tester1.id)

        expect(result).to have_key('projectName')
        expect(result['projectName']).to eq(proj1.project_name)

        expect(result).to have_key('activitiesCount')
        expect(result['activitiesCount']).to eq(2)
        expect(result).to have_key('activities')
        expect(result['activities']).to be_a(Array)
        expect(result['activities'].size).to eq(2)
      end
    end
  end
end
