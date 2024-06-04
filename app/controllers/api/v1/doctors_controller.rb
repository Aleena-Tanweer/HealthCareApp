class Api::V1::DoctorsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    before_action :set_doctor, only: [:show, :edit, :update, :destroy, :place_order, :view_orders_status, :view_feedback]
    before_action :authorize_doctor, only: [:show, :edit, :update, :destroy, :place_order, :view_orders_status, :view_feedback]
    after_action :verify_authorized, except: :index
  
    def new
      @doctor = Doctor.new
      authorize @doctor
      render json: @doctor
    end
  
    def create 
      @doctor = Doctor.new(doctor_params)
      authorize @doctor
      if @doctor.save 
        render json: {
          message: "Doctor Created", 
          status: :ok, 
          doctor: @doctor
        }
      else
        render json: { 
          message: "Error Creating Doctor", 
        }, status: :unprocessable_entity
      end
    end
  
    def show
      render json: @doctor
    end
  
    def edit
      render json: @doctor
    end
  
    def update
      if @doctor.update(doctor_params)
        render json: {
          message: "Doctor Updated",
          status: :ok,
          doctor: @doctor
        }
      else
        render json: { 
          message: "Error Updating Doctor", 
        }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @doctor.destroy
      render json: { message: "Doctor Deleted", status: :ok }
    end

    def place_order        
        order = @doctor.orders.new(order_params)
        if order.save
          render json: { message: "Order Placed Successfully", order: order }, status: :ok
        else
          render json: { message: "Error Placing Order", errors: order.errors }, status: :unprocessable_entity
        end
    end

    def view_orders_status
        orders_status = @doctor.orders.pluck(:status)
        render json: { message: "Orders Status", orders_status: orders_status }, status: :ok
    end

    def view_feedback
        feedbacks = @doctor.patients.map { |patient| { patient_name: patient.name, feedback: patient.order.test.result_document } }
        render json: { message: "Feedback and Lab Test Results", feedbacks: feedbacks }, status: :ok
    end
  
    private
  
    def set_doctor
      @doctor = Doctor.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Doctor not found" }, status: :not_found
    end
  
    def doctor_params 
      params.require(:doctor).permit(:specialization, :clinic_name)
    end

    def order_params
        params.require(:order).permit(:name, :description, :patient_id)
    end
  
    def authorize_doctor
      authorize @doctor
    end
  end
  