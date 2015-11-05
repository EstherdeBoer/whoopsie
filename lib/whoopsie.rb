require "exception_notification"
require "whoopsie/engine"
require "whoopsie/railtie"

module Whoopsie
  def self.report_and_swallow
    yield
  rescue StandardError => e
    handle_exception(e)
  end

  def self.handle_exception(exception, data = {})
    if Rails.application.config.whoopsie.enable
      ExceptionNotifier.notify_exception(exception, data)
    else
      raise exception
    end
  end
end
