class ShopsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user, only: %i[ manage edit update ]
  before_action :set_shop, only: %i[ show edit update destroy ]

  # GET /shops or /shops.json
  def index
    @shops = Shop.where.not(user: current_user)
    @is_follow = Followship.where(user: current_user, shop: @shop).exists?
  end

  # GET /shops/1 or /shops/1.json
  def show
    @products = Product.where(shop: @shop)
    @is_follow = Followship.find_by(user: current_user, shop: @shop)
  end

  # GET /shops/manage
  def manage
    @shop = Shop.find_by(user: current_user)
    @products = Product.where(shop: @shop)
    @orders = Order.where(products: @products)
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops or /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to shops_manage_path, notice: 'Shop was successfully created.' }
        format.json { render :manage, status: :created, location: @shop }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1 or /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1 or /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_shop
    @shop = Shop.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shop_params
    params.require(:shop).permit(:name, :user_id)
  end

  def require_user
    unless Shop.exists?(user: current_user)
      flash[:error] = 'create a shop first'
      redirect_to new_shop_path
    end
  end
end
