class ErrorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  class JavaScriptError < Struct.new(:message)
    def backtrace
      []
    end
  end

  newrelic_ignore if defined?(NewRelic) && respond_to?(:newrelic_ignore)

  def create
    if Rails.application.config.whoopsie.enable
      report = params[:error_report]
      report.merge!(params[:extra]) if params[:extra]
      report.merge!(headers: request.headers.to_h)
      ExceptionNotifier.notify_exception JavaScriptError.new(report["message"]), data: report
      render plain: "error acknowledged"
    else
      render plain: "error ignored"
    end
  end

  def bang
    raise "boom!"
  end

  def ping
    app_name  = Rails.application.engine_name
    db_status = (ActiveRecord::Base.connection.tables.length > 0) ? "ok" : "empty"
    render plain: "#{app_name} #{db_status}"
  end
end
