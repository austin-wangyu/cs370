class Tutor < User
  has_many :meetings
  has_many :evaluations, through: :meetings
  has_many :questions, through: :evaluations

  def full_name
    self.first_name + ' ' + self.last_name
  end

end
