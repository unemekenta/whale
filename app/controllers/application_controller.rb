class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action do
    I18n.locale = :ja
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  # user情報を変更可能にする例
  def configure_permitted_parameters
    request.session_options[:skip] = true
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :nickname, :image])
  end

  INDEX_LIMIT = 1000
end
