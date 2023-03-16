class LogHelper
  def self.log(message, type = 'debug')
    Rails.logger.send(type, message)
  end

  def self.exception(exception, object, method)
    tags = {
      log: "Exception occurred when trying run #{method}",
      exception: { class: exception.class, message: exception.message },
      class: object.class,
      environment: Rails.env.downcase,
      stacktrace: exception.backtrace.first(10)
    }

    log(tags, 'error')
  end
end
