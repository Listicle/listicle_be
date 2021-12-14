require 'rails_helper'

module Queries
  module Activities
    RSpec.describe 'query tasks',type: :request do
      before(:each) do
        User.delete_all
        @tester1 = create(:user)
        @tester2 = create(:user)
        @proj1 = create(:project, user: @tester1)
        @proj2 = create(:project, user: @tester2)
        @proj3 = create(:project, user: @tester2)
        @act1 = create(:activity, project: @proj1)
        @act2 = create(:activity, project: @proj1)
        @act3 = create(:activity, project: @proj3)
        @act4 = create(:activity, project: @proj3)
        @act5 = create(:activity, project: @proj3)
        @do1 = create(:task, activity: @act1)
        @do2 = create(:task, activity: @act1)
        @do3 = create(:task, activity: @act1)
        @do4 = create(:task, activity: @act3)
        @do5 = create(:task, activity: @act4)
        @do6 = create(:task, activity: @act4)
        @do7 = create(:task, activity: @act5)
      end

      it "returns one task, happy path" do

        def query(id:)
          <<~GQL
            query {
              task(id:#{id}) {
                id
                activityId
                taskName
                completed
              }
            }
          GQL
        end

        post '/graphql', params: { query: query(id: @do1.id)}
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(json).not_to have_key('message')
        expect(json).to have_key('data')
        expect(json['data']).to be_a(Hash)
        expect(json['data']).to have_key('task')
        expect(json['data']['task']).to be_a(Hash)

        result = json['data']['task']

        expect(result.size).to eq(4)
        expect(result).to have_key('id')
        expect(result['id'].to_i).to eq(@do1.id)

        expect(result).to have_key('activityId')
        expect(result['activityId'].to_i).to eq(@act1.id)

        expect(result).to have_key('taskName')
        expect(result['taskName']).to eq(@do1.task_name)
      end

      it "does not return a task without id, sad path" do

        def sad
          <<~GQL
            query {
              task {
                id
                activityId
                taskName
                completed
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
        expect(json['errors'][0]['message']).to eq("Field 'task' is missing required arguments: id")
      end
    end
  end
end
