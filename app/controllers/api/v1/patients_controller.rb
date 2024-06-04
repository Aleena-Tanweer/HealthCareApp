class Api::V1::PatientsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    before_action :set_patient, only: [:show, :edit, :update, :destroy, :view_orders, :view_order_status, :view_test_results, :receive_feedback, :personal_dashboard]
    before_action :authorize_patient, only: [:show, :edit, :update, :destroy, :view_orders, :view_order_status, :view_test_results, :receive_feedback, :personal_dashboard]
    after_action :verify_authorized, except: [:index, :view_orders, :view_order_status, :view_test_results, :receive_feedback, :personal_dashboard]
  
    def show
      render json: @patient
    end
  
    def new
      @patient = Patient.new
      authorize @patient
      render json: @patient
    end
  
    def edit
      render json: @patient
    end
  
    def create
      @patient = Patient.new(patient_params)
      authorize @patient
      if @patient.save
        render json: {
          message: "Patient Created",
          status: :ok,
          patient: @patient
        }
      else
        render json: {
          message: "Error Creating Patient",
        }, status: :unprocessable_entity
      end
    end
  
    def update
      if @patient.update(patient_params)
        render json: {
          message: "Patient Updated",
          status: :ok,
          patient: @patient
        }
      else
        render json: {
          message: "Error Updating Patient",
        }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @patient.destroy
      render json: { message: "Patient Deleted", status: :ok }
    end
  
    def view_orders
      orders = @patient.orders
      render json: orders
    end
  
    def view_order_status
      order = @patient.orders.find(params[:order_id])
      render json: { status: order.status }
    end
  
    def view_test_results
      order = @patient.orders.find(params[:order_id])
      test_results = order.test.result_document
      render json: test_results
    end
  
     
    
  
    private
  
    def set_patient
      @patient = Patient.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Patient not found" }, status: :not_found
    end
  
    def patient_params
      params.require(:patient).permit(:date_of_birth, :address, :contact_number, :fasting_requirements)
    end
  
    def authorize_patient
      authorize @patient
    end
  end
  