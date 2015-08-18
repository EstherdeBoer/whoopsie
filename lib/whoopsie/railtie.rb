module Whoopsie
  class Railtie < Rails::Railtie
    Config = Struct.new(:enable)
    config.whoopsie = Config.new

    initializer "whoopsie.configure_middleware" do
      Rails.application.middleware.insert_before ActiveRecord::ConnectionAdapters::ConnectionManagement, ExceptionNotification::Rack

      ExceptionNotification.configure do |config|
        # Ignore additional exception types.
        # ActiveRecord::RecordNotFound, AbstractController::ActionNotFound and ActionController::RoutingError are already added.
        # config.ignored_exceptions += %w{ActionView::TemplateError CustomError}

        # Adds a condition to decide when an exception must be ignored or not.
        # The ignore_if method can be invoked multiple times to add extra conditions.
        config.ignore_if do |exception, options|
          ! Rails.application.config.whoopsie.enable
        end
      end
    end
  end
end

ExceptionNotifier.module_eval do
  def self.handle_exception(exception, *extra)
    if Rails.application.config.whoopsie.enable
      notify_exception(exception, *extra)
    else
      raise exception
    end
  end
end
