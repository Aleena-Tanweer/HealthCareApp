class Api::V1::OrdersController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    before_action :set_order, only: [:show, :edit, :update, :destroy]
    before_action :authorize_order, only: [:show, :edit, :update, :destroy]

    
    def index
       render json: @orders
    end
  
    def show
      authorize @order
      render json: @order
    end
  
    def new
      @order = Order.new
      authorize @order
      render json: @order
    end
  
    def create
      @order = Order.new(order_params)
      authorize @order
      if @order.save
        render json: {
          message: "Order Created",
          status: :ok,
          order: @order
        }
      else
        render json: {
          message: "Error Creating Order",
          errors: @order.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  
    def edit
       authorize @order
       render json: @order
    end
  
    def update
      if @order.update(order_params)
        authorize @order
        render json: {
          message: "Order Updated",
          status: :ok,
          order: @order
        }
      else
        render json: {
          message: "Error Updating Order",
          errors: @order.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  
    def destroy
      authorize @order
      @order.destroy
      render json: { message: "Order Deleted", status: :ok }
    end
  
    private
  
    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Order not found" }, status: :not_found
    end
  
    def order_params
      params.require(:order).permit(:patient_id, :doctor_id, :date_of_order, :status)
    end
  
    def authorize_order
      authorize @order
    end 
      
  
    
  end

  

