require 'rails_helper'

module Queries
  module Projects


    RSpec.describe 'query project',type: :request do
      it "can create a new project" do
        tester = create(:user)
        # proj = create(:project, user: tester)
        proj1 = Project.create!(project_name: "test query", user: tester)
        proj2 = Project.create!(project_name: "yet another query", user: tester)

        def query(user_id:)
          # <<~GQL
          #   mutation {
          #    createProject(input: {
          #      projectName: "I will destroy you 2",
          #      userId: #{user_id}
          #    }) {
          #      project {
          #        id,
          #        userId,
          #        projectName
          #      }
          #      errors
          #    }
          #   }
          # GQL

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
        result = json['data']['projects']
        require "pry"; binding.pry

        # expect do
        #   post '/graphql', params: { query: query(user_id: tester.id)}

          # json = JSON.parse(response.body)
          # data = json['data']['createProject']
          # require "pry"; binding.pry
        # end
        # end.to change { Project.count }.by(1)
      end
    end
  end
end
