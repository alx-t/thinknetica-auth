Sequel.seed do
  def run
    [
      ['User 01', 'user01@test.com', 'password01'],
      ['User 02', 'user02@test.com', 'password02'],
      ['User 03', 'user03@test.com', 'password03']
    ].each do |name, email, password|
      User.create name: name, email: email, password: password, password_confirmation: password
    end
  end
end 
