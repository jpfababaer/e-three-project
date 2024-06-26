# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  bookings_count         :integer
#  email                  :text             default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  username               :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trainer_schedules, class_name: "Schedule", foreign_key: "trainer_id" 
  has_many :training_sessions, class_name: "Booking", foreign_key: "client_id"   
  has_many :booked_appointments, class_name: "Booking", foreign_key: "trainer_id" 
        
  enum role: { clients: 0, personal_trainers: 1 } 
end
