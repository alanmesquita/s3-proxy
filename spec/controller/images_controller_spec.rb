describe ImagesController do

  let(:token) { S3Proxy.config.batman['token'] }
  let(:router) { S3Proxy::Application.router }
  let(:headers) { {"HTTP_ACCESS_TOKEN" => token } }

  describe "#execute,  GET /image" do

    context "When request doesn't has token" do
      it "" do
        get "/image/asd", router do |response|
          expect(response.status).to eq 403
        end

      end
    end

    context "When request has token" do
      it "old image, 302" do
        get "/image/teste.jpg", router, headers do |response|
          expect(response.status).to eq(302)
        end
      end

      it "new image, 302" do
        get "/image/2014/02/02/image/teste.jpg", router, headers do |response|
          expect(response.status).to eq(302)
        end
      end

    end
  end
end
