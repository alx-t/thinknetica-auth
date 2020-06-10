RSpec.describe AuthRoutes, type: :routes do
  describe 'GET /v1/sessions' do
    context 'invalid token' do
      it 'returns ad error' do
        get '/v1/sessions/invalid_token'

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Доступ к ресурсу ограничен'
          }          
        )
      end
    end

    context 'valid token' do
      let(:user) { create :user, email: 'user@test.com' }
      let(:session) { create :user_session, user: user }

      before do
        user
        session
      end      

      it 'returns an user' do
        token = JwtEncoder.encode(uuid: session.id)

        get "/v1/sessions/#{token}"

        expect(last_response.status).to eq(200)
        expect(response_body['data']).to a_hash_including(
          'id' => user.id.to_s,
          'type' => 'user'
        )      
      end
    end
  end 
end