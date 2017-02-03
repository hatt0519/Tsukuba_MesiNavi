module TsukubaMesinavi
  module Api
    class ApiPlacePhotoClient < ApiClient

      def request_place_photo(request)
        get_result(TsukubaMesinavi::Entity::RequestPlacePhoto::END_POINT, request.create_request) do |response|
          place_details = TsukubaMesinavi::Entity::ResponsePlacePhoto.new(response)
        end
      end

    end
  end
end
