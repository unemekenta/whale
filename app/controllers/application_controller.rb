class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action do
    I18n.locale = :ja
  end

  STATUS_SUCCESS = 'SUCCESS'
  STATUS_FAILURE = 'ERROR'

  INDEX_LIMIT = 1000
end
