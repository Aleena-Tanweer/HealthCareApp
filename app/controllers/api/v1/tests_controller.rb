class Api::V1::TestsController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
    before_action :set_test, only: [:show, :edit, :update, :destroy]
    before_action :authorize_test, only: [:show, :edit, :update, :destroy]
  
    def index
      @tests = Test.all
      render json: @tests
    end
  
    def show
      render json: @test
    end
  
    def new
      @test = Test.new
      authorize @test
      render json: @test
    end
  
    def create
      @test = Test.new(test_params)
      authorize @test
      if @test.save
        render json: {
          message: "Test Created",
          status: :ok,
          test: @test
        }
      else
        render json: {
          message: "Error Creating Test",
          errors: @test.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  
    def edit
      render json: @test
    end
  
    def update
      if @test.update(test_params)
        render json: {
          message: "Test Updated",
          status: :ok,
          test: @test
        }
      else
        render json: {
          message: "Error Updating Test",
          errors: @test.errors.full_messages
        }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @test.destroy
      render json: { message: "Test Deleted", status: :ok }
    end
  
    private
  
    def set_test
      @test = Test.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Test not found" }, status: :not_found
    end
  
    def test_params
      params.require(:test).permit(:order_id, :name, :description, :fasting_required, :status, :result_document)
    end
  
    def authorize_test
      authorize @test
    end
  end
  