require 'json'
module TsukubaMesinavi
  module Api
    class ApiPlaceDetailsClient < ApiClient

      def request_place_details_to_obj(request)
        get_result(TsukubaMesinavi::Entity::RequestPlaceDetails::END_POINT, request.create_request) do |response|
          result = response["result"]
          place_details = TsukubaMesinavi::Entity::ResponsePlaceDetails.new(result["name"],
                                                                            result["opening_hours"],
                                                                            result["photos"],
                                                                            result["website"])
        end
      end

      def request_place_details_to_json(request)
        place_details = {}
        get_result(TsukubaMesinavi::Entity::RequestPlaceDetails::END_POINT, request.create_request) do |response|
          result = response["result"]
          place_details[:name] = result["name"]
          place_details[:opening_hours] = result["opening_hours"]
          place_details[:photos] = result["photos"]
          place_details[:website] = result["website"]
          place_details.to_json
        end
      end
    end
  end
end
