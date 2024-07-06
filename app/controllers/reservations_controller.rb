class ReservationsController < ApplicationController
    before_action :set_hotel, only: [:new, :create, :show, :index, :edit, :update, :destroy]
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  
    def new
      @reservation = Reservation.new(
        check_in: params[:check_in],
        check_out: params[:check_out],
        number_of_people: params[:number_of_people]
      )
    end
  
    def create
      @reservation = @hotel.reservations.new(reservation_params)
      @reservation.user = current_user
      if @reservation.save
        redirect_to hotel_reservations_path(@hotel), notice: '予約が完了しました。'
      else
        render :new
      end
    end
  
    def show
    end
  
    def index
      @reservations = current_user.reservations
    end
  
    def edit
    end
  
    def update
      if @reservation.update(reservation_params)
        redirect_to hotel_reservations_path(@hotel), notice: '施設の予約情報を更新しました。'
      else
        render :edit
      end
    end
  
    def destroy
      @reservation.destroy
      redirect_to hotel_reservations_path(@hotel), notice: '施設の予約情報を削除しました。'
    end
  
    private
  
    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end
  
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:check_in, :check_out, :number_of_people)
    end
  end
  
  