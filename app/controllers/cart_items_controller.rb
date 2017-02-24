class CartItemsController < ApplicationController

  before_action :set_cart_item, only: [ :edit, :update, :destroy]

  def new
    @cart = Cart.new
  end

  def create
    @cart_item = CartItem.new(cart_item)

    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to @cart_item, notice: 'Product image was successfully created.' }
        format.json { render :show, status: :created, location: @cart_item }
      else
        format.html { render :new }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @cart_item.update(cart_item_params)
        format.html { redirect_to @cart_item, notice: 'Cart_item was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_url, notice: 'Item was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_cart_item
    @cart_item = CartItem.find( params[:id] )
  end

  def cart_params
    params.require(:cart_item).permit(:cart_id, :product_id, :quantity)
  end

end
