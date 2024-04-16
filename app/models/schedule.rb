# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  day_of_week :string           not null
#  duration    :integer          default(60)
#  end_time    :datetime         not null
#  start_time  :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  trainer_id  :integer          not null
#
# Indexes
#
#  index_schedules_on_trainer_id  (trainer_id)
#
# Foreign Keys
#
#  trainer_id  (trainer_id => users.id)
#
class Schedule < ApplicationRecord
  belongs_to :trainer, class_name: "User"

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :day_of_week, presence: true
end
