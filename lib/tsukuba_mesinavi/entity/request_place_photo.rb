module TsukubaMesinavi
  module Entity
    class RequestPlacePhoto

      END_POINT = "https://maps.googleapis.com/maps/api/place/photo"
      MAX_WIDTH = 500
      MAX_HEIGHT = 500

      attr_reader :maxwidth, :maxheight, :photo_reference

      def initialize(photoreference)
        @photo_reference = photoreference
      end

      def create_request
        request = {key: Rails.application.secrets.google_api_key, maxwidth: MAX_WIDTH, maxheight: MAX_HEIGHT, photoreference: @photo_reference}
      end

    end
  end
end
