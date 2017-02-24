class ShopsController < ApplicationController
  def index

  end

  def show
    api_place_details_client = TsukubaMesinavi::Api::ApiPlaceDetailsClient.new
    @shops = []
    @shops_unknown = []
    @week = Date.today.wday - 1
    Shop.all.each do |shop_from_db|
      shop = api_place_details_client.request_place_details_to_obj(TsukubaMesinavi::Entity::RequestPlaceDetails.new(shop_from_db.place_id))
      if shop.present?
        if shop.opening_hours.nil?
          @shops_unknown.push(shop)
        elsif  shop.opening_hours["open_now"]
          @shops.push(shop)
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def show_details
    api_place_details_client = TsukubaMesinavi::Api::ApiPlaceDetailsClient.new
    @shop_api = api_place_details_client.request_place_details_to_obj(TsukubaMesinavi::Entity::RequestPlaceDetails.new(params[:place_id]))
    @shop_info = Shop.where(place_id: params[:place_id]).to_a.shift
    @location = {lat: params[:lat], lng: params[:lng]}
    @api_key = Rails.application.secrets.google_api_key
  end
end
