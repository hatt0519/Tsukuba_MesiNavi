class ShopsController < ApplicationController

  before_action :get_week, only: [:show_now_open, :show]
  before_action :get_api_key, only: [:new, :show]
  before_action :instanciate_api_place_details_client, except: [:index, :new]
  before_action :get_shop_details, only: [:show, :edit_categories]
  before_action :authenticate_user!, only: [:new]

  def index

  end

  def new
    @shop = Shop.new
  end

  def show
    shop_id = params[:shop_id]
    get_categories(shop_id)
    get_category_others(shop_id)
  end

  def search
    shop_name = params[:name] + " つくば"
    @api_place_search_client = TsukubaMesinavi::Api::ApiPlaceSearchClient.new
    @shops = @api_place_search_client.request_place_search_to_obj(TsukubaMesinavi::Entity::RequestPlaceSearch.new(shop_name))
    @lat = @shops.first.lat
    @lng = @shops.first.lng
    @shop = Shop.new(name: @shops.first.name)
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      shop_api = @api_place_details_client.request_place_details_to_obj(TsukubaMesinavi::Entity::RequestPlaceDetails.new(@shop.id, @shop.place_id))
      redirect_to shop_path(@shop.id, shop_id: @shop.id, place_id: @shop.place_id, lat: shop_api.lat, lng: shop_api.lng, registed: true)
    else
      get_api_key
      render :new
    end
  end

  def show_now_open
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
    CategoriesOwnedByShop.create(category_owned_by_shop)
    CategoryOther.create({shop_id: shop_id, name: category_other})
    get_categories(shop_id)
    get_category_others(shop_id)
    @message = "保存しました"
    respond_to do |format|
      format.js
    end
  end

  private
    def get_week
      wday = Date.today.wday - 1
      @week = wday != -1 ? wday : 6
    end

    def get_api_key
      @api_key = Rails.application.secrets.google_api_key
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

    def shop_params
      params.require(:shop).permit(:name, :place_id)
    end
end
