module Users
  class CreateService
    prepend BasicService

    option :user do
      option :name
      option :email
      option :password
    end

    attr_reader :user

    def call
      @user = ::User.new(@user.to_h.merge(password_confirmation: @user.password))

      if @user.valid?
        @user.save
      else
        fail!(@user.errors)
      end
    end
  end    
end