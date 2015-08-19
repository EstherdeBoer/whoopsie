class ErrorsController < ApplicationController
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
      ExceptionNotifier.notify_exception JavaScriptError.new(report["message"]), data: report
      render plain: "error acknowledged"
    else
      render plain: "error ignored"
    end
  end

  def bang
    raise "boom!"
  end
end
