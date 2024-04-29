desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  p "Creating sample data"

  if Rails.env.development?
    Booking.destroy_all
    Schedule.destroy_all
    User.destroy_all
  end

  def generate_phone_number
    Faker::PhoneNumber.cell_phone.gsub(/\D/, "")
  end

  def unique_phone_number
    phone_number = generate_phone_number
    until !User.exists?(phone_number: phone_number)
      phone_number = generate_phone_number
    end
    phone_number
  end

  usernames = Array.new

  usernames << "client"
  usernames << "trainer"

  usernames.each do |username|
    role = username == "client" ? 0 : 1
    User.create(
      email: "#{username}@example.com",
      password: "password",
      first_name: "John Paul",
      last_name: "Fababaer",
      username: username.downcase,
      phone_number: unique_phone_number,
      role: role
    )
  end

  #Generate User accounts:
  12.times do
    first_name = Faker::Name.unique.first_name
    last_name = Faker::Name.unique.last_name
    username = "#{first_name[0].downcase}#{last_name.downcase}"

    User.create(
      first_name: first_name,
      last_name: last_name,
      username: username,
      password: "password",
      email: "#{username}@example.com",
      phone_number: unique_phone_number,
      role: [0, 1].sample,
    )
  end

  #Keep it simple: selecting one day for trainer's availability.
  User.personal_trainers.each do |trainer|
    today = DateTime.now
    day_of_week = "Monday"
    start_time = DateTime.new(today.year, today.month, today.day, 7, 0, 0)
    end_time = start_time + 11.hours

    schedule = IceCube::Schedule.new(start_time.to_time, end_time: end_time.to_time)
    rule = IceCube::Rule.weekly.day(day_of_week.downcase.to_sym).count(1)
    schedule.add_recurrence_rule(rule)
    occurrences = schedule.all_occurrences

    occurrences.each do |occurrence|
      schedule = Schedule.create(
        trainer_id: trainer.id,
        start_time: occurrence.start_time,
        end_time: occurrence.end_time,
        day_of_week: day_of_week
      )
    end
  end

  #Initialize one simple Schedule with all its hourly slots.
  schedule = Schedule.first
  start_time = schedule.start_time
  end_time = schedule.end_time

  hourly_slots = []

  current_time = start_time
  while current_time < end_time
    next_hour_time = current_time + 1.hour
    hourly_slots << { start_time: current_time, end_time: next_hour_time }
    current_time = next_hour_time
  end

  #Strictly for visualization: remove slot to avoid double-booking.
  User.clients.each do |client|
    hourly_slots.each do |slot|
      if rand < 0.25
        booking = client.training_sessions.create(
          trainer_id: schedule.trainer_id,
          started_at: slot[:start_time],
          ended_at: slot[:end_time],
        )
        hourly_slots.delete(slot)
      end
    end
  end
end
