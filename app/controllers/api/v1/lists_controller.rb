class Api::V1::ListsController < ApplicationController
  respond_to :json, :xml

  def index
    @lists = List.find_by(user_id: params[:user_id])
    render json: @lists
  end

  def create
    @list = List.new(list_params)
    if @list.save
      render json: @list
    end
  end

  def show
    @list = List.find_by_id(params[:id])
    render json: @list
  end

  def update
    @list = List.find_by_id(params[:id])
    @list.update(list_params) if (@list && list_params)
    render json: @list
  end

  def destroy
    @list = List.find_by_id(params[:id])
    @list.destroy if @list
    redirect_to api_v1_lists_path, status: 303
  end

  private

  def list_params
    params.permit(:name)
  end
end
