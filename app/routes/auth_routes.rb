class AuthRoutes < Application
  helpers Auths

  namespace '/v1' do
    post '/signup' do
      user_params = validate_with!(UserParamsContract)

      result = Users::CreateService.call(
        user: user_params[:user]
      )

      if result.success?
        serializer = UserSerializer.new(result.user)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.user
      end      
    end

    post '/login' do
      session_params = validate_with!(SessionParamsContract)

      result = Sessions::CreateService.call(
        session_params[:session]
      )

      if result.success?
        status 201
        json(token: result.session.token)
      else
        status 422
        error_response result.errors        
      end
    end 

    get '/sessions/:token' do
      result = Auth::FetchUserService.call(extracted_token['uuid'])

      if result.success?
        serializer = UserSerializer.new(result.user)

        status 200
        json serializer.serializable_hash
      else
        status 422
        error_response result.errors
      end      
    end
  end
end
