require 'rails_helper'

module Queries
  module Projects
    RSpec.describe 'query project',type: :request do
      context 'happy path' do
        it "can create a new project" do
          tester = create(:user)
          proj1 = create(:project, user: tester)
          proj2 = create(:project, user: tester)
          # proj1 = Project.create!(project_name: "test query", user: tester)
          act1 = create(:activity, project: proj1)
          act2 = create(:activity, project: proj2)
          act3 = create(:activity, project: proj2)


          def query(user_id:)

            <<~GQL
              query {
                projects {
                id
                projectName
                activities {
                  id
                  title
                  tasks {
                    id
                    taskName
                  }
                }
              }
            }
            GQL
          end

          post '/graphql', params: { query: query(user_id: tester.id)}
          json = JSON.parse(response.body)
          # binding.pry

          expect(response).to be_successful
          expect(response.status).to eq(200)

          expect(json).to have_key('data')
          expect(json['data']).to be_a(Hash)
          expect(json['data']).to have_key('projects')
          expect(json['data']['projects']).to be_a(Array)

          result = json['data']['projects'][0]
          expect(result.size).to eq(3)
          expect(result).to have_key('id')
          expect(result).to have_key('projectName')
          expect(result).to have_key('activities')
          expect(result['activities']).to be_a(Array)
          expect(result['activities'].size).to eq(1)
        end
      end

      context 'sad path' do
        xit "can create a new project" do
          # tester = create(:user)
          tester = 1
          proj1 = create(:project, user: tester)
          proj2 = create(:project, user: tester)

          def query(user_id)
            <<~GQL
              query {
                projects {
                id
                projectName
                activities {
                  id
                  title
                  tasks {
                    id
                    taskName
                  }
                }
              }
            }
            GQL
          end

          post '/graphql', params: { query: query(user_id: tester.id) }
          json = JSON.parse(response.body)
          binding.pry
        end
      end
    end
  end
end

# [{"id"=>"1", "projectName"=>"test query", "activities"=>[]},
#  {"id"=>"2", "projectName"=>"yet another query", "activities"=>[]}]
