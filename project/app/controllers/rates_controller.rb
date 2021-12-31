class RatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_rate, only: %i[ show edit update destroy ]

  # GET /rates or /rates.json
  def index
    @order = Order.find(params[:order_id])
    @rates = Rate.where(product: @order.product)
  end

  # GET /rates/1 or /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
    @order = Order.find(params[:order_id])
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates or /rates.json
  def create
    @rate = Rate.new(rate_params)
    @order = Order.find(params[:order_id])

    respond_to do |format|
      if @rate.save
        @order.update(status: 4)
        format.html { redirect_to orders_path, notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1 or /rates/1.json
  def update
    @order = Order.find(params[:order_id])
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to order_rate_path(@order, @rate), notice: "Rate was successfully updated." }
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1 or /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: "Rate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rate
    @rate = Rate.find(params[:id])
    @order = Order.find(params[:order_id])
  end

  # Only allow a list of trusted parameters through.
  def rate_params
    params.require(:rate).permit(:user_id, :product_id, :review)
  end
end
