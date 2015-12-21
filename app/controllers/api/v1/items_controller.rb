class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml
  before_action :find_list, :authenticate

  def index
    @items = @list.items
    render json: @items
  end

  def create
    @item = @list.items.new(item_params)
    @item.done = false
    if @item.save
      render json: @item
    end
  end

  def show
    @item = @list.items.find_by_id(params[:id])
    render json: @item
  end

  def update
    @item = @list.items.find_by_id(params[:id]) if @list
    @item.update(item_params) if @item && item_params
    render json: @item
  end

  def destroy
    @item = @list.items.find_by_id(params[:id]) if @list
    @item.destroy
    redirect_to api_v1_lists_path, status: 303
  end

  private

  def find_list
    @list = List.find_by_id(params[:list_id])
  end

  def item_params
    params.permit(:name)
  end
end
