json.extract! schedule, :id, :day_of_week, :start_time, :end_time, :duration, :trainer_id, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
