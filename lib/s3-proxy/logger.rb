require 'syslog/logger'

module S3Proxy
  module Logger
    module_function

    def log
      @log ||= Syslog::Logger.new 's3-proxy'
    end

    %w{debug info warn error fatal}.each do |level|
      self.class.send(:define_method, level) { |message| self.log.send(level, message) }
    end

  end
end
