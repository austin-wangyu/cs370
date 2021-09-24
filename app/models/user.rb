class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :requests
  has_many :meetings, through: :requests
  has_many :evaluations, through: :requests

  validates :first_name, presence: true, format: {with: /\A[a-zA-Z\u00C0-\u017F\s.'-]*\z/, message: "First name cannot contain numbers or special characters"}
  validates :last_name, presence: {message: "Last name cannot be blank"}, format: {with: /\A[a-zA-Z\u00C0-\u017F\s.'-]*\z/, message: "Last name cannot contain numbers or special characters"}
  validates :gender, presence: {message: "Gender cannot be blank"}
  validates :ethnicity, presence: {message: "Ethnicity cannot be blank"}
  validates :dsp, inclusion: {in:[true,false], message: "DSP cannot be blank"}
  validates :transfer,inclusion: {in:[true,false], message: "Transfer cannot be blank"}
  validates :major,presence: {message: "Major cannot be empty"}
  validates :pronoun, presence: {message: "Pronoun cannot be empty"}
  validates :term, presence: {message: "Term cannot be left empty"}
  validates :email, presence: {message: "Email cannot be blank"}, format: {with: /\A[a-z0-9\+\-_\.]+@berkeley.edu/i, message: "Must be an @berkeley.edu email"}

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def tutor?
    type == 'Tutor'
  end

  def tutee?
    type == 'Tutee'
  end

end
