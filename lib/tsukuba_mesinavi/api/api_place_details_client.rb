require 'json'
module TsukubaMesinavi
  module Api
    class ApiPlaceDetailsClient < ApiClient

      def request_place_details_to_obj(request)
        get_result(TsukubaMesinavi::Entity::RequestPlaceDetails::END_POINT, request.create_request) do |response|
          result = response["result"]
          return if result.nil?
          place_details = TsukubaMesinavi::Entity::ResponsePlaceDetails.new(request.shop_id,
                                                                            request.place_id,
                                                                            result["name"],
                                                                            result["opening_hours"],
                                                                            result["geometry"]["location"]["lat"],
                                                                            result["geometry"]["location"]["lng"],
                                                                            result["website"])
        end
      end

      def request_place_details_to_json(request)
        place_details = {}
        get_result(TsukubaMesinavi::Entity::RequestPlaceDetails::END_POINT, request.create_request) do |response|
          result = response["result"]
          place_details[:name] = result["name"]
          place_details[:opening_hours] = result["opening_hours"]
          place_details[:lat] = result["geometry"]["location"]["lat"]
          place_details[:lng] = result["geometry"]["location"]["lng"]
          place_details[:website] = result["website"]
          place_details.to_json
        end
      end
    end
  end
end
