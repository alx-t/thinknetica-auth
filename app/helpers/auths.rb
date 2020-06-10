module Auths
  def extracted_token
    JwtEncoder.decode(params[:token])
  rescue JWT::DecodeError
    {}
  end
end