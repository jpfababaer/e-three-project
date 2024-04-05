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
end
