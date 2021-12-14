require 'rails_helper'

module Queries
  module Activities
    RSpec.describe 'query activities',type: :request do
      it "returns one activity" do
        tester1 = create(:user)
        tester2 = create(:user)
        proj1 = create(:project, user: tester1)
        proj2 = create(:project, user: tester2)
        proj3 = create(:project, user: tester2)
        act1 = create(:activity, project: proj1)
        act2 = create(:activity, project: proj1)
        act3 = create(:activity, project: proj3)
        act4 = create(:activity, project: proj3)
        act5 = create(:activity, project: proj3)
        do1 = create(:task, activity: act1)
        do2 = create(:task, activity: act1)
        do3 = create(:task, activity: act1)
        do4 = create(:task, activity: act3)
        do5 = create(:task, activity: act4)
        do6 = create(:task, activity: act4)
        do7 = create(:task, activity: act5)

        def query(id:)
          <<~GQL
            query {
              activity(id:#{id}) {
                id
                projectId
                title
                status
                tasksCount
                tasks {
                  id
                  taskName
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query(id: act1.id)}
        json = JSON.parse(response.body)
        binding.pry

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(json).not_to have_key('message')
        expect(json).to have_key('data')
        expect(json['data']).to be_a(Hash)
        expect(json['data']).to have_key('activity')
        expect(json['data']['activity']).to be_a(Hash)

        result = json['data']['activity']

        expect(result.size).to eq(6)
        expect(result).to have_key('id')
        expect(result['id'].to_i).to eq(act1.id)

        expect(result).to have_key('projectId')
        expect(result['projectId'].to_i).to eq(proj1.id)

        expect(result).to have_key('title')
        expect(result['title']).to eq(act1.title)

        expect(result).to have_key('tasksCount')
        expect(result['tasksCount']).to eq(3)
        expect(result).to have_key('tasks')
        expect(result['tasks']).to be_a(Array)
        expect(result['tasks'].size).to eq(3)
      end
    end
  end
end
