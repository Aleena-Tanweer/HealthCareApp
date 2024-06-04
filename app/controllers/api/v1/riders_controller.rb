class Api::V1::RidersController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    before_action :set_rider, only: [:show, :edit, :update, :destroy]
  
      
    def show
      render json: @rider
    end
  
    def new
      @rider = Rider.new
      render json: @rider
    end
  
    def edit
      render json: @rider
    end
  
    def create
      @rider = Rider.new(rider_params)
      if @rider.save
        render json: {
          message: "Rider Created",
          status: :ok,
          rider: @rider
        }
      else
        render json: {
          message: "Error Creating Rider",
        
        }, status: :unprocessable_entity
      end
    end
  
    def update
      if @rider.update(rider_params)
        render json: {
          message: "Rider Updated",
          status: :ok,
          rider: @rider
        }
      else
        render json: {
          message: "Error Updating Rider",
        
        }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @rider.destroy
      render json: { message: "Rider Deleted", status: :ok }
    end
  
    private
  
    def set_rider
      @rider = Rider.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Rider not found" }, status: :not_found
    end
  
    def rider_params
      params.require(:rider).permit(:vehicle_type, :area_of_coverage)
    end
  end
  