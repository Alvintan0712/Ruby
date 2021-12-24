class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @shop, _ = Shop.where(user: current_user)
    @products = Product.where(shop: @shop)
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @shop, _ = Shop.where(user: current_user)
  end

  # GET /products/1/edit
  def edit
    @shop, _ = Shop.where(user: current_user)
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
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /products/1/buy
  def buy
    print('action = ')
    print(params[:commit])
    @product = Product.find(params[:product_id])
    @quantity = Integer(params[:quantity])
    @cost = @product.price * @quantity
    case params[:commit]
    when 'Buy Now'
      print('Buy Now action')
    when 'Add To Cart'
      print('Add To Cart action')
    end
  end

  # PATCH/PUT /products/1/buy
  def pay
    @product = Product.find(params[:product_id])
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Paid successfully.' }
      format.json { render :show, status: :ok, location: @product }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :storage, :shop_id)
  end
end
