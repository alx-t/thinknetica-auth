class User < Sequel::Model
  plugin :secure_password
  one_to_many :sessions, class: :UserSession

  def validate
    super
    validates_presence :name, message: I18n.t(:blank, scope: 'model.errors.user.name')
    validates_presence :email, message: I18n.t(:blank, scope: 'model.errors.user.email')
    validates_unique :email, message: I18n.t(:uniqueness, scope: 'model.errors.user.email')
    validates_presence :password, message: I18n.t(:blank, scope: 'model.errors.user.password')
  end
end