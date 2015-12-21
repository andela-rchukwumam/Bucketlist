class Api::V1::ListsController < ApplicationController
  respond_to :json, :xml
  before_action :authenticate

  def index
    if list_params[:q].present?
      @lists = List.where(name: list_params[:q])
    else
      @lists = List.where(user_id: @current_user.id)
    end
    results = Api::Paginate.new(params[:limit], params[:page]).pagination(@lists)
    render json: results, status: 200
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      render json: @list, status: 201
    else
      render json: @list.errors, status: 400
    end
  end

  def show
    @list = List.find_by_id(params[:id])
    if @list.nil?
      render json: { Error: 'List not found' }, status: 400
    else
      render json: @list, status: 200
    end
  end

  def update
    @list = List.find_by_id(params[:id])
    if @list && list_params
      @list.update(list_params)
    else
      render json: { Error: 'List not found' }, status: 400
    end
    if @list.update(list_params)
      render json: @list, status: 202
    else
      render json: @list.errors, status: 400
    end
  end

  def destroy
    @list = List.find_by_id(params[:id])
    render json: { Error: 'not found' } if @list.nil?
    if @list
      @list.destroy
      render json: { Deleted: 'Bucketlist has been deleted' }, status: 200
    end
  end

  private

  def list_params
    params.permit(:name, :q)
  end
end
