require 'rails_helper'

module Mutations
  module Projects
    RSpec.describe CreateProject,type: :request do
      it "can create a new project" do
        tester = create(:user)
        def query(user_id:)
          <<~GQL
            mutation {
             createProject(input: {
               projectName: "I will destroy you 2",
               userId: #{user_id}
             }) {
               project {
                 id,
                 userId,
                 projectName
               }
               errors
             }
            }
          GQL

          # <<~GQL
          #   mutation {
          #     createBook(
          #       authorId: #{user_id}
          #       projectName: "Tripwire"
          #     ) {
          #       id
          #       title
          #       publicationDate
          #       genre
          #       author {
          #         id
          #       }
          #     }
          #   }
          # GQL
        end

        expect do
          post '/graphql', params: { query: query(user_id: tester.id)}

        json = JSON.parse(response.body)
        data = json['data']['createProject']
        # require "pry"; binding.pry

        end.to change { Project.count }.by(1)
      end
    end
  end
end
