module SocialNetworks
  class FetchData < ApplicationService
    class Unprocessable < StandardError; end
    BASE_URL = ENV.fetch('SOCIAL_NETWORKS_URL', nil)

    step :fetch_twitter_data
    step :fetch_facebook_data
    step :fetch_instagram_data

    def fetch_twitter_data(_input) = get('twitter', {})
    def fetch_facebook_data(input) = get('facebook', input)
    def fetch_instagram_data(input) = get('instagram', input)

    private

    def get(path, input)
      response = RestClient::Request.execute(
        method: :get,
        url: "#{BASE_URL}/#{path}"
      )

      fill(input, path, JSON.parse(response.body))
    rescue RestClient::InternalServerError
      fill(input, path, [])
    rescue StandardError => exception
      log_and_raise(exception, self, __method__)
    end

    def fill(input, path, data)
      input[path] = data
      Success(input)
    end

    def log_and_raise(exception, klass, method)
      LogHelper.exception(exception, klass, method)
      raise(Unprocessable)
    end
  end
end
