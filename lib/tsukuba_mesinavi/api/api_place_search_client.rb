require 'json'
module TsukubaMesinavi
  module Api
    class ApiPlaceSearchClient < ApiClient

      def request_place_search_to_obj(request)
        place_search = Array.new
        get_result(TsukubaMesinavi::Entity::RequestPlaceSearch::END_POINT, request.create_request) do |response|
          result = response["results"]
          return if result.nil?
          result.each do |r|
            entity = TsukubaMesinavi::Entity::ResponsePlaceSearch.new(r["geometry"]["location"]["lat"],
                                                                      r["geometry"]["location"]["lng"],
                                                                      r["name"],
                                                                      r["place_id"])
            place_search.push(entity)
          end
        end
        return place_search
      end
    end
  end
end
