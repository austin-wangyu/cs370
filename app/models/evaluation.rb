class Evaluation < ApplicationRecord
  has_one :meeting
  has_many :question

  validates :status, presence: true, inclusion: { in: %w(pending complete), message: "Must be valid status"}, on: :update, :if => :took_place

  def meeting
    Meeting.find_by_id(self.meeting_id)
  end

  def tutor
    self.meeting.tutor
  end

  def request
    self.meeting.request
  end

  def tutee
    self.meeting.tutee
  end

  def pending?
    self.status == 'pending'
  end

  def complete?
    self.status == "complete"
  end

end
