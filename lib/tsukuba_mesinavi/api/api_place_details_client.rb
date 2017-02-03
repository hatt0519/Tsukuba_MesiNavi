module TsukubaMesinavi
  module Api
    class ApiPlaceDetailsClient < ApiClient

      def request_place_details(request)
        get_result(TsukubaMesinavi::Entity::RequestPlaceDetails::END_POINT, request.create_request) do |response|
          result = response["result"]
          place_details = TsukubaMesinavi::Entity::ResponsePlaceDetails.new(result["name"],
                                                                            result["opening_hours"],
                                                                            result["photos"],
                                                                            result["website"])
        end
      end

    end
  end
end
