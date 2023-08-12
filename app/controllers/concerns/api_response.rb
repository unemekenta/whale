module ApiResponse
  extend ActiveSupport::Concern

  STATUS_SUCCESS = 'SUCCESS'
  STATUS_FAILURE = 'ERROR'

  def return_data(message, data, status_code = :ok)
    render json: { status: STATUS_SUCCESS, message: message, data: data }, code: status_code
  end

  def return_error(message, status_code = :unprocessable_entity)
    render json: { status: STATUS_FAILURE, error: message }, code: status_code
  end

  def session_options_skip
    request.session_options[:skip] = true
  end
end
