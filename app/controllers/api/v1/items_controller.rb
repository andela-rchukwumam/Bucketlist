class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml
  before_action :find_list, :authenticate

  def index
    @items = @list.items
    render json: @items, status: 200
  end

  def create
    @item = @list.items.new(item_params)
    @item.done = false
    if @item.save
      render json: @item, status: 201
    else
      render json: { Error: "can't be blank" }, status: 400
    end
  end

  def show
    @item = @list.items.find_by_id(params[:id])
    if @item
      render json: @item
    else
      render json: { Error: "Item does not exist" }, status: 400
    end
  end

  def update
    @item = @list.items.find_by_id(params[:id]) if @list
    @item.update(item_params) if @item && item_params
    render json: @item
  end

  def destroy
    @item = @list.items.find_by_id(params[:id]) if @list
    @item.destroy
    render json: { Success: "Item has been deleted" }, status: 200
  end

  private

  def find_list
    @list = List.find_by_id(params[:list_id])
  end

  def item_params
    params.permit(:name)
  end
end
