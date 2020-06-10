class UserSession < Sequel::Model
  UserSession.plugin :uuid, field: :id
  many_to_one :user

  def token
    JwtEncoder.encode(uuid: id)
  end
end