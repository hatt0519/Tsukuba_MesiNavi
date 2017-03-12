module TsukubaMesinavi
  module Entity
    class RequestPlaceDetails

      END_POINT = "https://maps.googleapis.com/maps/api/place/details/json"

      attr_reader :shop_id
      attr_reader :place_id

      def initialize(shop_id, place_id)
        @shop_id = shop_id
        @place_id = place_id
      end

      def create_request
        request = {key: Rails.application.secrets.google_api_key, place_id: @place_id}
      end

    end
  end
end
