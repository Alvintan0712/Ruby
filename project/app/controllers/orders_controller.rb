class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.where(user: current_user, status: [1,2,3,4])
    @orders_send = Order.where(user: current_user, status: 1)
    @orders_receive = Order.where(user: current_user, status: 2)
    @orders_rate = Order.where(user: current_user, status: 3)
  end

  def cart
    @cart = Order.where(user: current_user, status: 0)
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
              when 4
                'Done'
              else
                'Unknown'
              end
    @order_items = OrderItem.where(order: @order)
    @rate = Rate.find_by(product: @order.product, user: current_user)
  end

  # GET /orders/new
  def new
    @order = new_order
    @order.price = get_price(params['item'])
    @items = parse_items(params['item'])
    @order_items = new_order_items
    @shop = order_shop

    if params['commit'] == 'Add To Cart'
      if @order.save
        add_to_cart
        redirect_to orders_path
      else
        render product_path(@order.product)
      end
    end
  end

  # GET /orders/1/edit
  def edit
    @shop = order_shop
    @items = Item.where(product: @order.product)
    @order_items = OrderItem.where(order: @order)
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.price = get_price(params['order']['item'])
    @items = parse_items(params['order']['item'])
    @order_items = new_order_items
    @user = User.find(params[:order][:user_id].to_i)
    @shop = order_shop

    product = @order.product
    respond_to do |format|
      if enough && @order.save
        save_all
        format.html { redirect_to @order, notice: 'Paid Successfully.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { redirect_to product_path(product), notice: 'Balance not enough or out of stock' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @items = parse_items(params['order']['item'])
    @order.price = get_price(params['order']['item'])
    @order.address = params['order']['address']
    @order.phone = params['order']['phone']
    @order.delivery = params['order']['delivery']
    @order_items = OrderItem.where(order: @order)
    @user = @order.user
    @shop = order_shop

    respond_to do |format|
      if enough && @order.save
        save_all
        update_order_items
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { redirect_to @order, notice: 'Poor Guy' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH /orders/1/send
  def send_item
    @order = Order.find(params[:order_id])
    @order.status = 2
    @order.save
    respond_to do |format|
      format.html { redirect_to shops_manage_path, notice: 'This order was sent.' }
      format.json { head :no_content }
    end
  end

  # PATCH /orders/1/receive
  def receive_item
    @order = Order.find(params[:order_id])
    @order.status = 3
    @order.save
    respond_to do |format|
      format.html { redirect_to orders_path, notice: 'Parcel Received.' }
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
    params.require(:order).permit(:product_id, :user_id, :address, :phone, :delivery, :price)
  end

  def order_item_params
    params.permit(:order_id, :quantity, :cost)
  end

  def order_shop
    @order.product.shop
  end

  def new_order
    order = Order.new
    order.product = Product.find(params[:product_id])
    order.user = current_user
    order
  end

  def get_price(items)
    price = 0
    items.each do |_, value|
      quantity = value['quantity'].to_i
      item = Item.find(value['item_id'].to_i)
      price += item.cost * quantity
    end
    price
  end

  def new_order_items
    order_items = Array.new
    @items.each do |item, quantity|
      cost = item.cost * quantity
      order_items.append(OrderItem.new({'item_id' => item.id, 'quantity' => quantity, 'cost' => cost}))
    end
    order_items
  end

  def update_order_items
    @items.each do |item, quantity|
      cost = item.cost * quantity
      order_item = @order_items.find_by(item: item)
      order_item.update(quantity: quantity, cost: cost)
    end
  end

  def parse_items(dict)
    items = Array.new
    dict.each do |_, value|
      item = Item.find(value['item_id'].to_i)
      quantity = value['quantity'].to_i
      items.append([item, quantity])
    end
    items
  end

  def enough
    @user.balance -= @order.price
    stock_positive = true
    @order_items.each do |order_item|
      order_item.item.stock -= order_item.quantity
      order_item.item.sale  += order_item.quantity
      stock_positive &= order_item.item.stock.positive?
    end
    @user.balance.positive? && stock_positive
  end

  def save_all
    add_to_cart
    purchase
  end

  def add_to_cart
    @order_items.each do |order_item|
      order_item.order = @order
      order_item.item.save
      order_item.save
    end
  end

  def purchase
    seller = order_shop.user
    seller.balance += @order.price
    @order.update(status: 1)
    @user.save
    seller.save
  end
end
