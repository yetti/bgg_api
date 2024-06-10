# frozen_string_literal: true

require "faraday"
require "faraday/retry"
require "faraday/decode_xml"
require "faraday/follow_redirects"
require "httpx/adapters/faraday"

module BggApi
  module V2
    class Client
      BGG_API_BASE_URL = "https://www.boardgamegeek.com/xmlapi2/"

      def initialize(logger: nil, cache: nil)
        @logger = logger
        @cache = cache
      end

      def thing(params)
        raise ArgumentError, "id is required" if params[:id].nil?

        request(method: :get, endpoint: "thing", body: params)
      end

      def family(params)
        raise ArgumentError, "id is required" if params[:id].nil?

        request(method: :get, endpoint: "family", body: params)
      end

      def forumlist(params)
        raise ArgumentError, "id is required" if params[:id].nil?

        request(method: :get, endpoint: "forumlist", body: params)
      end

      def forum(params)
        raise ArgumentError, "id is required" if params[:id].nil?

        request(method: :get, endpoint: "forum", body: params)
      end

      def thread(params)
        raise ArgumentError, "id is required" if params[:id].nil?

        request(method: :get, endpoint: "thread", body: params)
      end

      def user(params)
        raise ArgumentError, "name is required" if params[:name].nil?

        request(method: :get, endpoint: "user", body: params)
      end

      def guild(params)
        raise ArgumentError, "id is required" if params[:id].nil?

        request(method: :get, endpoint: "guild", body: params)
      end

      def plays(params)
        raise ArgumentError, "username is required" if params[:id].nil?

        request(method: :get, endpoint: "plays", body: params)
      end

      def collection(params)
        raise ArgumentError, "username is required" if params[:id].nil?

        request(method: :get, endpoint: "collection", body: params)
      end

      def hot(params)
        raise ArgumentError, "type is required" if params[:type].nil?

        request(method: :get, endpoint: "hot", body: params)
      end

      def search(params)
        raise ArgumentError, "query is required" if params[:query].nil?

        request(method: :get, endpoint: "search", body: params)
      end

      private

      def client
        @client ||= begin
          options = {
            url: BGG_API_BASE_URL,
            request: {
              open_timeout: 5,
              read_timeout: 5
            }
          }

          retry_options = {
            max: 2,
            interval: 0.05,
            interval_randomness: 0.5,
            backoff_factor: 2
          }

          Faraday.new(**options) do |f|
            f.request :url_encoded
            f.request :retry, retry_options

            f.response :xml
            f.response :follow_redirects
            f.response :raise_error
            f.response :logger, @logger, headers: true, bodies: true, log_level: :debug unless @logger.nil?

            f.use :http_cache, store: @cache, logger: @logger unless @cache.nil?

            f.adapter :httpx
          end
        end
      end

      def request(method:, endpoint:, body: {})
        response = client.public_send(method, endpoint, body)
        {
          status: response.status,
          body: response.body
        }
      rescue Faraday::Error => e
        raise ApiError.new(message: e.message, faraday_error_class: e.class)
      end
    end
  end
end
