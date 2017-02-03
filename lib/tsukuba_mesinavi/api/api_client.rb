require 'json'
require 'typhoeus'

module TsukubaMesinavi
  module Api
    class ApiClient
      def initialize
        @hydra = Typhoeus::Hydra.hydra
      end

      def request_get_method(url, params)
        request = Typhoeus::Request.new(
          url,
          method: :get,
          params: params,
          headers: { Accept: "text/json" }
        )
        @hydra.queue(request)
        @hydra.run
        response = request.response
      end

      def get_result(url, params)
        response = request_get_method(url, params)
        if response.code == 200
          result = JSON.load(response.body)
          yield(result)
        elsif response.code == 302
          yield(response.effective_url)
        else
          return
        end
      end
    end
  end
end
