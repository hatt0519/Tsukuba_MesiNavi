class ShopsController < ApplicationController
  def index
    api_place_details_client = TsukubaMesinavi::Api::ApiPlaceDetailsClient.new
    api_place_photo_client = TsukubaMesinavi::Api::ApiPlacePhotoClient.new
    @shops = []
    @shops_unknown = []
    @week = Date.today.wday - 1
    Shop.all.each do |shop_from_db|
      shop = api_place_details_client.request_place_details(TsukubaMesinavi::Entity::RequestPlaceDetails.new(shop_from_db.place_id))
      if shop.opening_hours.nil?
        @shops_unknown.push(shop)
      elsif  shop.opening_hours["open_now"] && !shop.photos.nil?
        @shops.push(shop)
      end
    end
  end

  def show
  end
end
