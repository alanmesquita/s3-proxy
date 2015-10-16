module S3Proxy

  # When trying to access video from Admin, we need to grant
  # all access even with geoblocked videos
  #
  class Admin
    def initialize(request, session_id)
      @request    = request
      @session_id = session_id
    end

    def has_admin_access?
      return false unless admin_request?

      return has_valid_session?
    end

    private

    # Check if request is an Akamai admin url
    #
    def admin_request?
      @request == S3Proxy.config.batman['admin_url']
    end

    # Verify in Admin if the current access have a valid session
    # This verification is made through _prost_session cookie
    #
    def has_valid_session?
      begin
        S3Proxy::Logger.error("Validating user session on admin")

        response = S3Proxy::Service::Admin.new.get_user_session @session_id
        return response["auth"]
      rescue Exception => e
        S3Proxy::Logger.error(
          "We received a unexpered message from admin, for security reasons, "\
          "we will block this request. Message: #{e.message}"
        )

        return false
      end
    end
  end
end
