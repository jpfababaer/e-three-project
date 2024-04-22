class SchedulePolicy < ApplicationPolicy
  def index?
    user.personal_trainers? # Only trainers can access the schedules index
  end

  def show?
    user.trainer? && record.trainer_id == user.id # Trainers can only see their own schedules
  end

  def new?
    user.personal_trainers? # Only trainers can create schedules
  end

  def create?
    user.personal_trainers? # Only trainers can create schedules
  end

  def edit?
    user.personal_trainers? && record.trainer_id == user.id # Trainers can only edit their own schedules
  end

  def update?
    user.personal_trainers? && record.trainer_id == user.id # Trainers can only update their own schedules
  end

  def destroy?
    user.personal_trainers? && record.trainer_id == user.id # Trainers can only delete their own schedules
  end
end
