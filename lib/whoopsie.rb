require "exception_notification"
require "whoopsie/engine"
require "whoopsie/railtie"

module Whoopsie
  def self.report_and_swallow
    yield
  rescue StandardError => e
    ExceptionNotifier.notify_exception(e)
  end
end
