describe "Videos Api" do
  path "/videos" do
    get "shows users videos" do
      tags "Videos"
      security [ Bearer: [] ]
      parameter name: :page, :in => :query, :type => :integer
      parameter name: :per_page, :in => :query, :type => :integer
      let(:page) { 1 }
      let(:per_page) { 1 }

      response "401", 'authentication failed' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
        run_test!
      end

      response "200", 'returns lists of users videos' do
        let!(:video) { create(:video, user: user) }
        let(:user) { create(:user) }
        let(:Authorization) { "Bearer #{generate_jwt_for_user(user)}" }

        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :string },
                  type: { type: :string },
                  attributes: { 
                    type: :object,
                    properties: {
                      start_time: { type: :integer },
                      end_time: { type: :integer },
                      status: { type: :string },
                      original_file_url: { type: :string },
                      cropped_file_url: {type: :string }
                    }
                  }
                }
              }
            }
          }


        run_test! do
          data = JSON.parse(response.body)
          expect(data['data'][0]['id']).to eq(video.id.to_s)
        end
      end
    end
    
    post "creates video" do
      tags "Videos"
      security [ Bearer: [] ]
      consumes 'application/x-www-form-urlencoded'
      parameter name: :start_time, in: :formData, type: :integer
      parameter name: :end_time, in: :formData, type: :integer
      parameter name: :video, in: :formData, type: :file
      let(:user) { create(:user) }
      let(:start_time) { 10 }
      let(:end_time) { 20 }
      let(:video) {  Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "fixtures", "files", "sample_video.mp4")) }
      before do
        allow_any_instance_of(ActionDispatch::Http::UploadedFile).to receive(:content_type).and_return('video/mp4')
      end

      response "401", 'authentication failed' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }

        run_test!
      end

      response "200", "creates new video" do
        let(:Authorization) { "Bearer #{generate_jwt_for_user(user)}" }

        run_test!
      end

      response "400", "params validation error" do
        let(:Authorization) { "Bearer #{generate_jwt_for_user(user)}" }
        let(:start_time) { -10 }

        run_test!
      end

    end
  end 

  path "/videos/{id}" do
    get "shows one video" do
      tags "Videos"
      security [ Bearer: [] ]
      parameter name: :id, :in => :path, :type => :string
      let!(:video) { create(:video, user: user) }
      let(:user) { create(:user) }

      response "401", 'authentication failed' do
        let(:id) { video.id }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
        run_test!
      end

      response "200", 'returns lists of users videos' do
        let(:id) { video.id }
        let(:Authorization) { "Bearer #{generate_jwt_for_user(user)}" }

        schema type: :object,
          properties: {
            data: {
              type: :object,
              properties: {
                id: { type: :string },
                type: { type: :string },
                attributes: { 
                  type: :object,
                  properties: {
                    start_time: { type: :integer },
                    end_time: { type: :integer },
                    status: { type: :string },
                    original_file_url: { type: :string },
                    cropped_file_url: {type: :string }
                  }
                }
              }
            }
          }


        run_test! do
          data = JSON.parse(response.body)
          expect(data['data']['id']).to eq(video.id.to_s)
        end
      end
    end
  end
end