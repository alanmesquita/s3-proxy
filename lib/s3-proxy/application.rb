module S3Proxy
  module Application
    module_function

    def router
      Rack::Router.new do
        get '/image/*path' => ImagesController
        get '/*video'      => VideosController
      end
    end
  end
end
