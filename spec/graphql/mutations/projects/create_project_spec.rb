require 'rails_helper'

module Mutations
  module Projects
    RSpec.describe CreateProject,type: :request do
      describe 'resolve' do
        it "creates a new project" do
          tester = create(:user)

          expect do
            post '/graphql', params: { query: query(user_id: tester.id)}

          json = JSON.parse(response.body)
          data = json['data']['createProject']

          end.to change { Project.count }.by(1)
        end

        it 'returns a project' do
          tester = create(:user)

          post '/graphql', params: { query: query(user_id: tester.id)}
          json = JSON.parse(response.body)
          data = json['data']['createProject']['project']

          expect(data['id']).to be_present
          expect(data['id']).to be_a String
          expect(data['userId']).to be_a Integer
          expect(data['userId']).to eq(tester.id)
          expect(data['projectName']).to be_a String
          expect(data['projectName']).to eq("Wuv more")
        end
      end

      def query(user_id:)
        <<~GQL
          mutation {
           createProject(input: {
             userId: #{user_id}
             projectName: "Wuv more"
           }) {
             project {
               id
               userId
               projectName
             }
             errors
           }
          }
        GQL
      end
    end
  end
end
