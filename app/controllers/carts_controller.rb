class CartsController < ApplicationController
  before_action :set_cart, only: [ :add_item, :remove_item, :clear_cart]
  # before_action :verify_owner, only: [ :edit, :add_item, :remove_item, :clear_cart ]



  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    @cart = Cart.find( params["id"] )
    # raise

    respond_to :html, :json


  end

  # GET /carts/new
  def new
    if @current_user.nil?
      redirect_to login_path
    end
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find( params["id"] )
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def destroy_cart_item
    cart_item = CartItem.find( params["id"] )
    cart_item.destroy
    flash[:success] = "Item successfully deleted from cart."
  end

  def remove_item
    # binding.pry
    item = CartItem.find_by( cart_id: @cart.id, product_id: params["id"] )
    @cart.remove_item item.product.id
    # render 'show', cart: @cart
  end

  # def add_item
  #   # If the user's last cart has completed all transactions, make a new one.
  #   binding.pry
  #
  #   if !@current_user.carts.last.purchase_completed && @current_user.carts.last.present?
  #     cart = @current_user.carts.last
  #   else
  #     cart = Cart.create({ user_id: @current_user.id, purchase_completed: false })
  #   end
  #
  #   if CartItem.find_by( cart_id: cart.id, product_id: params["id"] )
  #     item = CartItem.find_by( cart_id: cart.id, product_id: params["id"] )
  #     cart.add_item item.product.id
  #   else
  #     item = CartItem.create( cart_id: cart.id, product_id: params["id"], quantity: 1 )
  #   end
  #
  #   render 'show', cart: @cart
  # end


  def add_item
    # If the user's last cart has completed all transactions, make a new one.

    if !@current_user.carts.last.purchase_completed && @current_user.carts.last.present?
      cart = @current_user.carts.last
    else
      cart = Cart.create({ user_id: @current_user.id, purchase_completed: false })
    end

    # binding.pry

    if CartItem.find_by( cart_id: cart.id, product_id: params["id"] )
      item = CartItem.find_by( cart_id: cart.id, product_id: params["id"] )
      cart.add_item item.product.id unless cart.user.id != params["user_id"].to_i
    else
      item = CartItem.create( cart_id: cart.id, product_id: params["id"], quantity: 1 )
    end

    # render 'show', cart: @cart
  end

  def clear_cart
    @cart.clear_cart
    render 'show', cart: @cart
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      if @current_user.nil?
        redirect_to login_path
      elsif @current_user.carts.nil?
        @cart = Cart.create( user_id: @current_user.id )
      elsif @current_user.carts.where( purchase_completed: false ).empty?
        @cart = Cart.create( user_id: @current_user.id )
      else
        @cart = @current_user.carts.find_by( purchase_completed: false )
      end
      # redirect_to cart_path( @cart )
    end

    def verify_owner
      if !@current_user || cart.find( params[:id] ).user != @current_user
        redirect_to :back
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:user_id, :completed)
    end
end
