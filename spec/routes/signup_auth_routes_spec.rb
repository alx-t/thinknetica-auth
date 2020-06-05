RSpec.describe AuthRoutes, type: :routes do  
  describe 'POST /v1/signup' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/v1/signup'
        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:user_params) do
        {
          name: 'User name',
          email: 'user@test.com',
          password: ''
        }
      end

      it 'returns an error' do
        post '/v1/signup', user: user_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите пароль',
            'source' => {
              'pointer' => '/data/attributes/password'
            }
          }          
        )
      end
    end

    context 'valid parameters' do
      let(:user_params) do
        {
          name: 'User name',
          email: 'user@test.com',
          password: 'password'
        }
      end

      let(:last_user) { User.last }

      it 'creates a new user' do
        expect { post '/v1/signup', user: user_params }
          .to change { User.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an user' do
        post '/v1/signup', user: user_params

        expect(response_body['data']).to a_hash_including(
          'id' => last_user.id.to_s,
          'type' => 'user'
        )
      end
    end
  end
end