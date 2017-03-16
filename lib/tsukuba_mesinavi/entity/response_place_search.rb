module TsukubaMesinavi
  module Entity
    class ResponsePlaceSearch
      attr_reader :lat
      attr_reader :lng
      attr_reader :name
      attr_reader :place_id

      def initialize(lat, lng, name, place_id)
        @lat = lat
        @lng = lng
        @name = name
        @place_id = place_id
      end
    end
  end
end
