# This class is called before all "controllers".
# Rack needs call method to initialize route.
#
class ApplicationController

  # This method call child method execute, each "controller" needs call method
  # return array | response headers
  #
  def self.call(env)
    response = self.new(env)
    if response.valid_key?
      return response.execute
    end

    S3Proxy::Logger.error("Header key doesn't match with S3Proxy key")
    response.render "Access Denied", status: 403
  end

  attr_reader :request

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  # This method validate key sended by header: 'Access-Token: S3Proxy'
  # return bool
  #
  def valid_key?
    request.env['HTTP_ACCESS_TOKEN'] == S3Proxy.config.application['token']
  end

  # This method is used to simplificate Rack response
  # return array | [status_code, content_type, [body_response]]
  #
  def render(body, options = {})
    status = options.delete(:status) || 200
    headers = {'Content-Type' => 'text/plain'}.merge(options)
    S3Proxy::Logger.error("event=application status=#{status}")

    [status, headers, [body]]
  end

end
