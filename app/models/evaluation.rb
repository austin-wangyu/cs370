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

  def self.to_csv
    attributes = self.attribute_names

      CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |eval|
          csv << eval.attributes.values
        end
      end
  end

  def self.total_hours
    self.where(:took_place => true).where(:status => "complete").sum(:hours)
  end

  def self.hours_ethnicity ethnicity
    #TODO
    #This where clause is saying where tutee.ethnicity contains an element called local variable ethnicity value.
    #Will need to change depending on how we categorize mutli-ethnic data.
    return Tutee.where("ethnicity @> ARRAY['#{ethnicity}']::varchar[]").joins(:evaluations).where("evaluations.took_place" => true).where("evaluations.status" => "complete").sum(:hours)
  end

  def self.hours_gender gender
    return Tutee.where(gender: gender).joins(:evaluations).where("evaluations.took_place" => true).where("evaluations.status" => "complete").sum(:hours)
  end

  def self.hours_demographic_to_csv
    ethnicities = ['Asian','Black/African','Caucasian', 'Hispanic/Latinx', 'Native American',
      'Pacific Islander', 'Mixed', 'Other']
    genders = ['Male', 'Female', 'Non-Binary']

    attributes = ["Ethnicity/Gender", "Total Hours"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      ethnicities.each do |ethnicity|
        csv << [ethnicity, self.hours_ethnicity(ethnicity)]
      end

      genders.each do |gender|
        csv << [gender, self.hours_gender(gender)]
      end

      csv << ["Total Hours", Evaluation.total_hours]
    end
  end

  def self.hours_course course
    return Request.where(:course => course).joins(:meeting).joins(:evaluation).where("evaluations.took_place" => true).where("evaluations.status" => "complete").sum(:hours)
  end

  def self.hours_course_to_csv
    courses = Admin.course_list

    attributes = ["Ethnicity/Gender", "Total Hours"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      courses.each do |course|
        csv << [course, self.hours_course(course)]
      end

      csv << ["Total Hours", Evaluation.total_hours]
    end
  end


end
