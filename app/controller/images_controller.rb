require 'uri'

class ImagesController < ApplicationController
  def execute
    S3Proxy::Logger.info("Accessing image router")

    image = Image.new(URI.unescape(request.params[:path].join('/')))

    s3_url = image.s3_url
    S3Proxy::Logger.info("Redirecting to #{s3_url}")
    S3Proxy::Logger.info("event=image status=302")
    render 'Redirect', :status => 302, 'Location' => s3_url
  end
end
