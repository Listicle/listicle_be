require 'rails_helper'

module Queries
  module Users
    RSpec.describe 'query users',type: :request do
      it "returns all users" do
        tester1 = create(:user)
        tester2 = create(:user)
        tester3 = create(:user)
        proj1 = create(:project, user: tester1)
        proj2 = create(:project, user: tester2)
        proj3 = create(:project, user: tester2)

        def query
          <<~GQL
            query {
              users {
              id
              username
              projectsCount
              projects {
                id
                projectName
              }
            }
          }
          GQL
        end

        post '/graphql', params: { query: query}
        json = JSON.parse(response.body)
        # binding.pry

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(json).not_to have_key('message')
        expect(json).to have_key('data')
        expect(json['data']).to be_a(Hash)
        expect(json['data']).to have_key('users')
        expect(json['data']['users']).to be_a(Array)
        expect(json['data']['users'].size).to eq(3)

        result = json['data']['users'].first

        expect(result.size).to eq(4)
        expect(result).to have_key('id')
        expect(result).to have_key('username')
        expect(result).to have_key('projectsCount')
        expect(result['projectsCount']).to eq(1)
        expect(result['projectsCount']).to eq(tester1.projects.size)
        expect(result).to have_key('projects')
        expect(result['projects']).to be_a(Array)
        expect(result['projects'].size).to eq(1)
      end
    end
  end
end
