class ApplicationController < ActionController::Base
  unless Rails.env.development? || Rails.env.test?
    rescue_from StandardError, with: :internal_server_error
  end
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def internal_server_error(error = nil)
    log_error(error)
    render template: "errors/internal_server_error", layout: "error", status: :internal_server_error
  end

  def not_found(error = nil)
    log_error(error)
    render template: "errors/not_found", layout: "error", status: :not_found
  end

  private

    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end

    def log_error(error)
      return unless error

      Rails.logger.error <<~LOG
        [#{error.class}] #{error.message}
        #{error.backtrace&.join("\n")}
      LOG
    end
end
