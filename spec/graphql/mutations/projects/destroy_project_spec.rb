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
              # binding.pry

          expect(Project.count).to eq(0)
        end

        xit 'returns a project' do
          # post '/graphql', params: { query: query(id: proj.id) }
          # json = JSON.parse(response.body)
          # data = json['data']['destroyProject']
          #
          # expect(data).to include(
          #   'id'              => be_present,
          #   'title'           => 'Hero',
          #   'publicationDate' => 1984,
          #   'genre'           => 'Horror',
          #   'author'          => { 'id' => be_present }
          # )
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
