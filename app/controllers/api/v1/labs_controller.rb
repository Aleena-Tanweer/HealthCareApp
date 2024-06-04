class Api::V1::LabsController < ApplicationController
    before_action :set_lab, only: [:show, :edit, :update, :destroy]
  
    def index
      @labs = Lab.all
      render json: @labs
    end
  
    def show
    end
  
    def new
      @lab = Lab.new
      render json: @lab
    end
  
    def edit
    end
  
    def create
        @lab = Lab.new(lab_params)
    
        if @lab.save
          render json: @lab, status: :created
        else
          render json: { errors: @lab.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    
    def update
        if @lab.update(lab_params)
          render json: @lab
        else
          render json: { errors: @lab.errors.full_messages }, status: :unprocessable_entity
        end
    end
  
    
    def destroy
        @lab.destroy
        head :no_content
    end
  
    
    def received_orders
      @received_orders = current_lab.orders.where(status: 'received')
    end
    
  
  
  
    private
      
      def set_lab
        @lab = Lab.find(params[:id])
      end
  
      
      def lab_params
        params.require(:lab).permit(:name, :country_code)
      end
  
      
      def current_lab
        @current_lab ||= LabStaff.find_by(user_id: current_user.id)
      end
  end
  