module TsukubaMesinavi
  module Entity
    class ResponsePlaceDetails
      attr_reader :name
      attr_reader :opening_hours
      attr_accessor :photos
      attr_reader :website

      def initialize(name, opening_hours, photos, website)
        @name = name
        @opening_hours = opening_hours
        @photos = photos
        @website = website
      end

    end
  end
end
