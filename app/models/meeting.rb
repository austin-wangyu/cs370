class Meeting < ApplicationRecord
  has_one :evaluation

  def tutor
    Tutor.find_by_id(self.tutor_id)
  end

  def request
    Request.find_by_id(self.request_id)
  end

  def tutee
    self.request.tutee
  end

  def unscheduled?
    self.status == 'unscheduled'
  end

  def scheduled?
    self.status == 'scheduled'
  end

  def finished?
    self.status == 'finished'
  end

  # def isExpired
  # 	if self.set_time.nil?
  # 		return false
  # 	end
	# return self.set_time < Time.now
  # end
end
