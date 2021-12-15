require 'rails_helper'

module Mutations
  module Projects
    RSpec.describe DestroyProject, type: :request do
      before(:each) do
        @tester = create(:user)
        @project1 = create(:project, user_id: @tester.id)
      end

      describe 'resolve' do
        it 'removes a project' do
            post '/graphql', params: { query: query(id: @project1.id, user_id: @tester.id) }
            json = JSON.parse(response.body)
            data = json['data']

          expect(Project.count).to eq(0)
        end

        it 'returns a project' do
          post '/graphql', params: { query: query(id: @project1.id, user_id: @tester.id) }
          json = JSON.parse(response.body)
          data = json['data']['destroyProject']['project']

          expect(data).to include(
            'id'              => "#{@project1.id}",
            'projectName'     => @project1.project_name,
            'userId'          => @tester.id
          )

        end
      end

      def query(id:, user_id:)
        <<~GQL
        mutation {
          destroyProject(input: {
           id: #{id},
           userId: #{user_id}
          }) {
           project {
             id,
             projectName,
             userId
           }
           errors
          }
          }
        GQL
      end
    end
  end
end
