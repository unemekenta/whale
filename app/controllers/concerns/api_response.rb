module ApiResponse
  extend ActiveSupport::Concern

  def session_options_skip
    request.session_options[:skip] = true
  end
end
