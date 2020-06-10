module Auth
  class FetchUserService
    prepend BasicService

    param :id

    attr_reader :user

    def call
      return fail!(I18n.t(:forbidden, scope: 'services.auth.fetch_user_service')) if @id.blank? || session.blank?
      @user = session.user
    end

    private

    def session
      @session ||= UserSession.first(id: @id)
    end
  end
end