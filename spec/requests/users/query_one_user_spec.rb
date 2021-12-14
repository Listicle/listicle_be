require 'rails_helper'

module Queries
  module Users
    RSpec.describe 'query users',type: :request do
      it "returns one user" do
        tester1 = create(:user)
        tester2 = create(:user)
        tester3 = create(:user)
        proj1 = create(:project, user: tester1)
        proj2 = create(:project, user: tester1)
        proj3 = create(:project, user: tester2)

        def query(id:)
          <<~GQL
            query {
              user(id:#{id}) {
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

        post '/graphql', params: { query: query(id: tester1.id)}
        json = JSON.parse(response.body)
        # binding.pry

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(json).not_to have_key('message')
        expect(json).to have_key('data')
        expect(json['data']).to be_a(Hash)
        expect(json['data']).to have_key('user')
        expect(json['data']['user']).to be_a(Hash)

        result = json['data']['user']

        expect(result.size).to eq(4)
        expect(result).to have_key('id')
        expect(result['id'].to_i).to eq(tester1.id)

        expect(result).to have_key('username')
        expect(result['username']).to eq(tester1.username)

        expect(result).to have_key('projectsCount')
        expect(result['projectsCount']).to eq(2)
        expect(result).to have_key('projects')
        expect(result['projects']).to be_a(Array)
        expect(result['projects'].size).to eq(2)
      end
    end
  end
end
