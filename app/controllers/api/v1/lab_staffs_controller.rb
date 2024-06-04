class Api::V1::LabStaffsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    before_action :set_lab_staff, only: [:show, :edit, :update, :destroy]
    before_action :authorize_lab_staff, only: [:show, :edit, :update, :destroy]
  
    def show
      render json: @lab_staff
    end
  
    def new
      @lab_staff = LabStaff.new
      authorize @lab_staff
      render json: @lab_staff
    end
  
    def edit
      render json: @lab_staff
    end
  
    def create
      @lab_staff = LabStaff.new(lab_staff_params)
      authorize @lab_staff
      if @lab_staff.save
        render json: {
          message: "Lab Staff Created",
          status: :ok,
          lab_staff: @lab_staff
        }
      else
        render json: {
          message: "Error Creating Lab Staff",
        }, status: :unprocessable_entity
      end
    end
  
    def update
      if @lab_staff.update(lab_staff_params)
        render json: {
          message: "Lab Staff Updated",
          status: :ok,
          lab_staff: @lab_staff
        }
      else
        render json: {
          message: "Error Updating Lab Staff",
        }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @lab_staff.destroy
      render json: { message: "Lab Staff Deleted", status: :ok }
    end
  
    private
  
    def set_lab_staff
      @lab_staff = LabStaff.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Lab Staff not found" }, status: :not_found
    end
  
    def lab_staff_params
      params.require(:lab_staff).permit(:department)
    end
  
    def authorize_lab_staff
      authorize @lab_staff
    end
  end
  