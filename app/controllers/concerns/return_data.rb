module ReturnData
extend ActiveSupport::Concern
  def return_data(status, message, data)
    render json: { status: status, message: message, data: data }
  end

  def session_options_skip
    request.session_options[:skip] = true
  end
end