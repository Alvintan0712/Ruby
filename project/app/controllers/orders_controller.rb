class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.where(user: current_user)
  end

  # GET /orders/1 or /orders/1.json
  def show
    @status = case @order.status
              when 0
                'To Pay'
              when 1
                'To Send'
              when 2
                'To Receive'
              when 3
                'To Rate'
              else
                'Unknown'
              end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.product = Product.find(params[:product_id])
    @order.quantity = Integer(params[:quantity])
    @order.price = @order.product.price * @order.quantity
    @order.user = current_user

    # TODO: Add Order to Cart Table
    if params['commit'] == 'Add To Cart'
      if @order.save
        redirect_to orders_path
      else
        render product_path(@order.product)
      end
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    id = Integer(params[:order][:user_id])
    @user = User.find(id)
    @user.balance -= @order.price

    respond_to do |format|
      if @user.save && @order.save
        @order.update(status: 1)
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order = Order.find(params[:id])
    id = Integer(params[:order][:user_id])
    @user = User.find(id)
    @user.balance -= @order.price

    respond_to do |format|
      if @user.save && @order.update(order_params)
        @order.update(status: 1)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:product_id, :user_id, :price, :address, :phone, :quantity, :delivery)
  end
end
