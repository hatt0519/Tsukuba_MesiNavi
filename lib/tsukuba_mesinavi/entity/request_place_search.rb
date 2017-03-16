module TsukubaMesinavi
  module Entity
    class RequestPlaceSearch

      END_POINT = "https://maps.googleapis.com/maps/api/place/textsearch/json"

      attr_reader :search_query

      def initialize(search_query)
        @search_query = search_query
      end

      def create_request
        request = {key: Rails.application.secrets.google_api_key, query: @search_query}
      end

    end
  end
end
