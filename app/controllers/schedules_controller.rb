class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[ show edit update destroy ]
  before_action :availabilities, only: %i[ new edit]

  # GET /schedules or /schedules.json
  def index
    custom_order = { "Sunday" => 0, "Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6 }
    @schedules = current_user.trainer_schedules.sort_by { |schedule| custom_order[schedule.day_of_week] }
    authorize Schedule
  end

  # GET /schedules/1 or /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
    @availabilities = availabilities
    authorize @schedule
  end

  # GET /schedules/1/edit
  def edit
    @availabilities = availabilities
    authorize @schedule
  end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    authorize @schedule

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to schedules_path, notice: "Schedule was successfully created." }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
    authorize @schedule
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to schedules_path, notice: "Schedule was successfully updated." }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    authorize @schedule
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url, notice: "Schedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def schedule_params
    params.require(:schedule).permit(:trainer_id, :start_time, :end_time, :day_of_week, :duration)
  end

  def availabilities
    opening_hour = 5
    closing_hour = 21
    options = []
    (opening_hour..closing_hour).each do |hour|
      date_time = DateTime.new(Date.today.year, Date.today.month, Date.today.day, hour,0,0)
      options << [date_time.strftime("%l:%M %p"), date_time]
    end
    options
  end
end
