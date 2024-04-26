class AvailabilityService
  def self.availabilities
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
