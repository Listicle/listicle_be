require 'rails_helper'

module Queries
  module Tasks
    RSpec.describe 'query tasks',type: :request do
      context 'happy path' do
        it "returns tasks" do
          tester = create(:user)
          proj = create(:project, user: tester)
          act = create(:activity, project: proj)
          task1 = create(:task, activity: act)
          task2 = create(:task, activity: act)


          def query(activity_id:)

            <<~GQL
              query {
                tasks {
                  id
                  taskName
                }
            }
            GQL
          end

          post '/graphql', params: { query: query(activity_id: act.id)}
          json = JSON.parse(response.body)
          # binding.pry

          expect(response).to be_successful
          expect(response.status).to eq(200)

          expect(json).not_to have_key('message')
          expect(json).to have_key('data')
          expect(json['data']).to be_a(Hash)
          expect(json['data']).to have_key('tasks')
          expect(json['data']['tasks']).to be_a(Array)
          expect(json['data']['tasks'].size).to eq(2)

          result = json['data']['tasks'][0]
          expect(result.size).to eq(2)
          expect(result).to have_key('id')
          expect(result).to have_key('taskName')
        end
      end

      context 'sad path' do
        it "returns tasks" do
          post '/graphql'
          json = JSON.parse(response.body)

          expect(json).to be_a(Hash)
          expect(json).not_to have_key('data')
          expect(json).to have_key('errors')

          expect(json['errors']).to be_a(Array)
          expect(json['errors'][0]).to be_a(Hash)
          expect(json['errors'][0]).to have_key('message')
          expect(json['errors'][0]['message']).to eq("No query string was present")
        end
      end
    end
  end
end
