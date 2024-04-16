class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]
  before_action :trainer_slots, only: %i[ new ]

  # GET /bookings or /bookings.json
  def index
    @bookings = user_bookings
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings or /bookings.json
  def create
    @booking = Booking.new(booking_params)

    @booking.ended_at = @booking.started_at + 1.hour

    respond_to do |format|
      if @booking.save
        format.html { redirect_to bookings_path, notice: "Booking was successfully created." }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to booking_url(@booking), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def booking_params
    params.require(:booking).permit(:client_id, :trainer_id, :started_at, :ended_at)
  end

  def user_bookings
    bookings = Booking.all
    current_bookings = []

    bookings.each do |booking|
      if booking.trainer_id == current_user.id
        current_bookings << booking
      end
    end
    current_bookings
  end

  def trainer_slots
    @date = DateTime.parse(params[:date])
    @trainers_array = User.personal_trainers.joins(:trainer_schedules).where(schedules: { day_of_week: @date.strftime("%A") }).uniq

    @hourly_slots = []

    #Access trainer schedule for the specific day:
    @trainers_array.each do |trainer|
      schedule = trainer.trainer_schedules.find_by(day_of_week: @date.strftime("%A"))
      next unless schedule
      start_time = DateTime.new(@date.year, @date.month, @date.day, schedule.start_time.hour, schedule.start_time.min, schedule.start_time.sec)
      end_time = DateTime.new(@date.year, @date.month, @date.day, schedule.end_time.hour, schedule.end_time.min, schedule.end_time.sec)

      current_time = start_time
      while current_time < end_time
        next_hour_time = current_time + 1.hour
        @hourly_slots << { "trainer_id" => trainer.id, "started_at" => current_time, "ended_at" => next_hour_time }
        current_time = next_hour_time
      end
    end
  end
end
