module SocialNetworks
  class FetchData < ApplicationService
    class Unprocessable < StandardError; end
    BASE_URL = ENV.fetch('SOCIAL_NETWORKS_URL', nil)
    CACHE_EXPIRE = ENV.fetch('CACHE_EXPIRE', 1).to_i.hours

    step :fetch_data

    def initialize(...)
      super(...)
      @input = {}
    end

    def fetch_data
      [fetch_twitter_data, fetch_facebook_data, fetch_instagram_data].each(&:join)

      Success(@input)
    end

    private

    def fetch_twitter_data = prepare_thread { get('twitter') }
    def fetch_facebook_data = prepare_thread { get('facebook') }
    def fetch_instagram_data = prepare_thread { get('instagram') }

    def get(path)
      fill(path, cached_response_for(path))
    rescue RestClient::InternalServerError
      fill(path, [])
    rescue StandardError => exception
      log_and_raise(exception, self, __method__)
    end

    def cached_response_for(path)
      Rails.cache.fetch("#{self.class}.#{__method__}:#{path}", expires_in: CACHE_EXPIRE) do
        response = RestClient::Request.execute(
          method: :get,
          url: "#{BASE_URL}/#{path}"
        )

        JSON.parse(response.body)
      end
    end

    def fill(path, data)
      @input[path] = data
    end

    def log_and_raise(exception, klass, method)
      LogHelper.exception(exception, klass, method)
      raise(Unprocessable)
    end

    def prepare_thread
      Thread.new do
        Thread.current[:data] = yield
      end
    end
  end
end
