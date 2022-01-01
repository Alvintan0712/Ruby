class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: %i[ show edit update destroy ]

  def show
  end

  def new
    @item = Item.new
    @product = Product.find(params[:product_id])
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item.product, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    ensure_owner
  end

  def update
    ensure_owner
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to product_item_path(@item), notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    product = @item.product
    @item.destroy
    respond_to do |format|
      format.html { redirect_to product, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def ensure_owner
    @product = Product.find(params[:product_id])
    unless current_user == @product.shop.user
      respond_to do |format|
        format.html { redirect_to @product, alert: 'You are not product owner.' }
        format.json { head :no_content }
      end
    end
  end

  def item_params
    params.require(:item).permit(:product_id, :cost, :stock, :sale, :properties)
  end
end
