require 'uri'

module S3Proxy
  module Service

    # Use this class to create s3 authenticated url to access media
    # bucket
    # You need to set region, access key and secret key to athenticate
    # s3 credential to generate url
    #
    class S3

      def initialize(file, bucket)
        @bucket    = bucket
        @file      = file
        @s3_client = connection
      end

      # Generate tokenized url from s3 bucket
      # return string | s3 url
      #
      def generate_url
        S3Proxy::Logger.info(
          "Generating s3 url for file: #{@file} with bucket: #{S3Proxy.config.s3[@bucket]}"
        )

        tokenized_url = Aws::S3::Presigner.new(client: @s3_client).presigned_url(
          :get_object,
          key: @file,
          bucket: S3Proxy.config.s3[@bucket],
          expires_in: 60
        )

        parse_url tokenized_url
      end

      private

      # Connect on s3 service
      # return s3 client object
      #
      def connection
        Aws::S3::Client.new(
          region:            S3Proxy.config.s3['region'],
          access_key_id:     S3Proxy.config.s3['key'],
          secret_access_key: S3Proxy.config.s3['secret']
        )
      end

      # This method is used to change https to http
      # from s3 tokenized url
      #
      def parse_url(url)
        url = URI.parse(url)
        url.scheme = "http"
        url.to_s
      end
    end
  end
end
