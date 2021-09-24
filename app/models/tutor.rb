class Tutor < User
  has_many :meetings
  has_many :evaluations, through: :meetings
  has_many :questions, through: :evaluations

end
