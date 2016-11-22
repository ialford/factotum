require 'typhoeus/adapters/faraday'
require 'hash_ostruct'

# class for establishing a rest connection to an external source
class ExternalRestConnection
  attr_reader :base_url, :faraday_instance, :connection, :opts, :response
  attr_accessor :request_body

  def initialize(base_url: nil, connection_opts: {})
    @opts = connection_opts
    @base_url = base_url
    @connection = establish_connection
  end

  def max_retries
    @opts[:max_retries] ||= 2
  end

  def response_format
    @opts[:response_format] ||= 'xml'
  end

  # GET verb
  def get(path)
    @response = connection.get(path)
    process_response
  end

  # GET Illiad
  def get_illiad(path)
    @response = connection.get do |req|
      req.url path
      req.headers["ApiKey"] = rest_configuration["illiad_api_key"]
    end
    process_response
  end

  # PUT verb
  def put(path, payload)
    @response = connection.put(path, payload)
    process_response
  end

  # POST verb
  def post(path, payload)
    @response = connection.post(path, payload)
    process_response
  end

  # custom error class
  class Error < StandardError
  end

  private

  def rest_configuration
    if @rest_configuration.nil?
      path = File.join(Rails.root, "config", "rest.yml")
      @rest_configuration = YAML.load_file(path)[Rails.env]
    end
    @rest_configuration
  end

  def establish_connection
    Faraday.new(url: base_url) do |conn|
      @faraday_instance = conn
      setup_connection
    end
  end

  def setup_connection
      faraday_instance.request :retry, request_retry_opts
      faraday_instance.request :url_encoded
      faraday_instance.response :json, content_type: /text\/plain/
      faraday_instance.response :xml,  content_type: /\bxml$/
      faraday_instance.response :caching, file_cache, ignore_params: %w(access_token)
      faraday_instance.adapter :typhoeus
  end

  def file_cache
    ActiveSupport::Cache::FileStore.new(
      File.join(rails_root, '/tmp', 'cache'),
      namespace: 'api_rest_data',
      expires_in: 240  # four minutes
    )
  end

  def rails_root
    Rails.root
  end

  def request_retry_opts
    {
      max: max_retries,
      interval: 0.05,
      interval_randomness: 1,
      backoff_factor: 2
    }
  end

  def process_response
    type = response_content_type
    if expected_type?(response_content_type)
      if response_format == "xml"
        response.body.to_ostruct
      else
        JSON.parse(response.body)
      end
    else
      fail Error, "Unexpected type (Expect #{response_format}, Not #{type})"
    end
  end

  def expected_type?(type)
    if response_format == 'json'
      type =~ /text\/plain/
    else
      type =~ /#{response_format}/
    end
  end

  def response_content_type
    response.headers['Content-Type']
  end
end