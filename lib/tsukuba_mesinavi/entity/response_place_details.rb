module TsukubaMesinavi
  module Entity
    class ResponsePlaceDetails
      attr_reader :place_id
      attr_reader :name
      attr_reader :opening_hours
      attr_reader :lat
      attr_reader :lng
      attr_reader :website

      def initialize(place_id, name, opening_hours, lat, lng, website)
        @place_id = place_id
        @name = name
        @opening_hours = opening_hours
        @lat = lat
        @lng = lng
        @website = website
      end
    end
  end
end
