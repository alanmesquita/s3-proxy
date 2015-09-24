class Image

  attr_reader :image_path

  def initialize(image_path)
    @image_path = image_path
  end

  # Generate S3 tokenized url
  # return string | tokenized url
  #
  def s3_url
    bucket_key = bucket
    S3Proxy::Logger.error("event=image response=#{bucket_key}")
    S3Proxy::Service::S3.new(image_path, bucket_key).generate_url
  end

  private

  # This method is used to chose what bucket will be used in s3 url
  # return string | bucket config name
  #
  def bucket
    old_image? ? 'old_bucket_images' : 'new_bucket'
  end

  # Verify if image is old or new format:
  # old format: teste_image.jpg
  # new format: 2014/05/05/abcdefghijk/image/teste_image.jpg
  # return bool
  #
  def old_image?
    (image_path =~ /(\d+\/\d+\/\d+\/.*image\/)/).nil?
  end

end
