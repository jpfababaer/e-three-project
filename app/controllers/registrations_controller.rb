# app/controllers/custom_registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    bookings_path
  end
end
