class Request < ApplicationRecord
  has_one :meeting
  has_one :evaluation, through: :meeting

  validates :meeting_length, presence: {message: "Meeting length cannot be left empty"}
  validates_length_of :subject, in: 0..50, allow_blank: false

  def tutee
    User.find_by_id(self.user_id)
  end

  def open?
    self.status == 'open'
  end

  def matched?
    self.status == 'matched'
  end

  def closed_by_admin?
    self.status == 'closed by admin'
  end

  def self.to_csv
	attributes = Request.attribute_names

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |request|
        csv << request.attributes.values
      end
    end
  end

  def self.get_open_requests_by_course course
    Request.where(course: course, status: "open")
  end

  def matched?
    !Meeting.where(:request_id => id).first.nil?
  end
end
