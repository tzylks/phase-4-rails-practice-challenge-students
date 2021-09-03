class Student < ApplicationRecord
  validates :name, :major, :age, :instructor_id, presence: true
  validate :age_validate
  belongs_to :instructor

  def age_validate
    errors.add(:age, "You're too young, man") if age < 18
  end

end
