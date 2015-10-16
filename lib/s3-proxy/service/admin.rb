module S3Proxy
  module Service

    # Use this class to access Admin and get video information
    # You need a header called X-APIKEY to authenticate in Admin
    #
    class Admin

      # Access Admin and get video data
      # @parms string | video id
      # @return json | video data
      #
      def get_video(id)
        return nil if id.empty?

        S3Proxy::Logger.info("Getting Admin video with id #{id}")

        request = Typhoeus::Request.new(
          S3Proxy.config.admin['uri'] + '/videos/' + id,
          headers: {"X-APIKEY" => S3Proxy.config.admin['api_key']}
        )

        request.on_complete do | response |
          return JSON.parse(response.body) if response.success?

          S3Proxy::Logger.error("Admin responded with status: #{response.code}")
          S3Proxy::Logger.error("event=admin status=#{response.code}")
          raise Typhoeus::Errors::TyphoeusError, response.status_message
        end

        request.run
      end

      def get_user_session(user_section)
        S3Proxy::Logger.info("Checking user section with _admin_session=#{user_section}")

        request = Typhoeus::Request.new(
          S3Proxy.config.admin['uri'] + '/auth/status',
          headers: {
            "Cookie" => "_session=#{user_section}"
          }
        )

        request.on_complete do | response |
          return JSON.parse(response.body) if response.success?

          S3Proxy::Logger.error("admin responded with status: #{response.code}")
          S3Proxy::Logger.error("event=admin status=#{response.code}")
          raise Typhoeus::Errors::TyphoeusError, response.status_message
        end

        request.run
      end
    end
  end
end
