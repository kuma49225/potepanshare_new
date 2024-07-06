class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @hotels = Hotel.all
  end

  def my_hotels
    @hotels = current_user.hotels
  end

  def show
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = current_user.hotels.new(hotel_params)
    if @hotel.save
      redirect_to my_hotels_hotels_path, notice: 'ホテルが作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to my_hotels_hotels_path, notice: 'ホテルが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    redirect_to my_hotels_hotels_path, notice: 'ホテルが削除されました。'
  end

  def search
    @hotels = Hotel.where("address LIKE ?", "%#{params[:area]}%")
    render :index
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :description, :price, :address, :image)
  end
end


