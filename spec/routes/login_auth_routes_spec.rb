RSpec.describe AuthRoutes, type: :routes do
  describe 'POST /v1/login' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/v1/signup'
        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:session_params) do
        {
          email: 'user@test.com',
          password: ''
        }
      end

      it 'returns an error' do
        post '/v1/login', session: session_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Сессия не может быть создана'
          }          
        )
      end
    end

    context 'valid parameters' do
      let(:session_params) do
        {
          email: 'user@test.com',
          password: 'password'
        }
      end

      let(:user) { create :user, email: 'user@test.com' }

      before do
        user
      end

      it 'creates a new user' do
        expect { post '/v1/login', session: session_params }
          .to change { UserSession.count }.from(0).to(1)
        expect(last_response.status).to eq(201)
      end

      it 'returns an user' do
        post '/v1/login', session: session_params
        expect(response_body['token']).to eq(JwtEncoder.encode(uuid: user.sessions.first.id))
      end
    end    
  end
end