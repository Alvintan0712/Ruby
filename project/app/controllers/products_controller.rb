class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :ensure_owner, only: %i[ edit update destroy ]

  # GET /products or /products.json
  def index
    @shop = Shop.find_by(user: current_user)
    @products = Product.where(shop: @shop)
  end

  # GET /products/1 or /products/1.json
  def show
    @items = Item.where(product: @product)
    @shop = @product.shop
    @is_favourite = Favourite.find_by(user: current_user, product: @product)
    @rates = Rate.where(product: @product)
    @image = Image.find_by(product: @product)
  end

  # GET /products/new
  def new
    @product = Product.new
    @shop = Shop.find_by(user: current_user)
  end

  # GET /products/1/edit
  def edit
    @shop = Shop.find_by(user: current_user)
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to shops_manage_path, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def ensure_owner
    unless @product.shop.user == current_user
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You are not product owner' }
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :specification, :shop_id)
  end
end
