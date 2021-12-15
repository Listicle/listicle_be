require 'rails_helper'

module Queries
  module Users
    RSpec.describe 'query users',type: :request do
      before(:each) do
        User.delete_all
        @tester1 = create(:user)
        @proj1 = create(:project, user: @tester1)
        @proj2 = create(:project, user: @tester1)
        @proj3 = create(:project, user: @tester1)
      end

      it "returns one user, happy path" do

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

        post '/graphql', params: { query: query(id: @tester1.id)}
        json = JSON.parse(response.body)

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
        expect(result['id'].to_i).to eq(@tester1.id)

        expect(result).to have_key('username')
        expect(result['username']).to eq(@tester1.username)

        expect(result).to have_key('projectsCount')
        expect(result['projectsCount']).to eq(3)
        expect(result).to have_key('projects')
        expect(result['projects']).to be_a(Array)
        expect(result['projects'].size).to eq(3)
      end

      it "does not return a user without id, sad path" do

        def sad
          <<~GQL
            query {
              user {
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

        post '/graphql', params: { query: sad}
        json = JSON.parse(response.body)

        expect(json).to be_a(Hash)
        expect(json).not_to have_key('data')
        expect(json).to have_key('errors')

        expect(json['errors']).to be_a(Array)
        expect(json['errors'][0]).to be_a(Hash)
        expect(json['errors'][0]).to have_key('message')
        expect(json['errors'][0]['message']).to eq("Field 'user' is missing required arguments: id")
      end
    end
  end
end
