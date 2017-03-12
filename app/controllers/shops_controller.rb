class ShopsController < ApplicationController

  before_action :get_week, only: [:show, :show_details]
  before_action :instanciate_api_place_details_client, except: [:index]
  before_action :get_shop_details, only: [:show_details, :edit_categories]

  def index

  end

  def show
    @shops = []
    @shops_unknown = []
    Shop.all.each do |shop_from_db|
      shop = @api_place_details_client.request_place_details_to_obj(TsukubaMesinavi::Entity::RequestPlaceDetails.new(shop_from_db.id, shop_from_db.place_id))
      if shop.present?
        if shop.opening_hours.nil?
          @shops_unknown.push(shop)
        elsif shop.opening_hours["open_now"]
          @shops.push(shop)
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def show_details
    shop_id = params[:shop_id]
    @location = {lat: params[:lat], lng: params[:lng]}
    @api_key = Rails.application.secrets.google_api_key
    get_categories(shop_id)
    get_category_others(shop_id)
  end

  def edit_categories
    shop_id = params[:shop_id]
    get_checked_categories(shop_id)
    get_category_others(shop_id)
    respond_to do |format|
      format.js
    end
  end

  def update_categories
    shop_id = params[:shop_id]
    categories = params[:categories]
    category_other = params[:category_other] if params.has_key?(:category_other)
    category_owned_by_shop = Array.new
    categories.each do |category|
      category_owned_by_shop.push({shop_id: shop_id, category_id: category})
    end
    CategoriesOwnedByShop.destroy_all(shop_id: shop_id)
    CategoryOther.destroy_all(shop_id: shop_id)
    is_success = CategoriesOwnedByShop.create(category_owned_by_shop)
    CategoryOther.create({shop_id: shop_id, name: category_other})
    if is_success
      get_categories(shop_id)
      get_category_others(shop_id)
      @message = "保存しました"
    else
      @message = "保存に失敗しました"
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def get_week
      wday = Date.today.wday - 1
      @week = wday != -1 ? wday : 6
    end

    def instanciate_api_place_details_client
      @api_place_details_client = TsukubaMesinavi::Api::ApiPlaceDetailsClient.new
    end

    def get_shop_details
      @shop_api = @api_place_details_client.request_place_details_to_obj(TsukubaMesinavi::Entity::RequestPlaceDetails.new(params[:shop_id], params[:place_id]))
      @shop_info = Shop.where(place_id: params[:place_id]).to_a.shift
    end

    def get_categories(shop_id)
      @categories_owned_by_shop = Category.joins(:categories_owned_by_shop)
      .select("categories.id AS category_id, categories.name")
      .where("categories_owned_by_shops.shop_id = ?", shop_id)
    end

    def get_category_others(shop_id)
      @category_others = CategoryOther.where("shop_id = ?", shop_id)
    end

    def get_checked_categories(shop_id)
      @checked_categories = Array.new
      categories = Category.all
      categories_owned_by_shop = get_categories(shop_id)
      categories.each do |category|
        @checked_categories.push({category_id: category.id, name: category.name, checked: false, category_other: nil})
      end
      @checked_categories.map { |checked_category|
        categories_owned_by_shop.each do |category_owned_by_shop|
          checked = checked_category[:category_id] == category_owned_by_shop.category_id
          checked_category[:checked] = checked if checked
        end
      }
    end
end
