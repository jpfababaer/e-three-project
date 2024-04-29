# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  ended_at   :datetime         not null
#  started_at :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :integer          not null
#  trainer_id :integer          not null
#
# Indexes
#
#  index_bookings_on_client_id   (client_id)
#  index_bookings_on_trainer_id  (trainer_id)
#
# Foreign Keys
#
#  client_id   (client_id => users.id)
#  trainer_id  (trainer_id => users.id)
#
class Booking < ApplicationRecord
  belongs_to :client, class_name: "User", counter_cache: true
  belongs_to :trainer, class_name: "User", counter_cache: true

  validates :started_at, presence: true
  validates :ended_at, presence: true

  #Scope for filtering bookings based on role:
  scope :for_user_role, ->(user_role, user_id) {
    if user_role == "personal_trainers"
      where(trainer_id: user_id)
    elsif user_role == "clients"
      where(client_id: user_id)
    else
      none
    end
  }
end
