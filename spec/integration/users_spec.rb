require 'swagger_helper'

describe "Users API", swagger_doc: 'v1/swagger.yaml' do
  path "/users" do
    post "Creates new user" do
      tags 'Users'
      consumes 'application/json'

      response "201", "user created" do
        run_test!
        header 'Authorization', type: :string, description: "sets jwt authorization token in header"
      end
    end
  end
end