class QuestionTemplate < ApplicationRecord
  has_many :question

  def self.ordered_list_of_question_templates
    result = []
    QuestionTemplate.all.count.times do |x|
      result.push(QuestionTemplate.find_by!(order: x+1))
    end
    return result
  end

  def descriptor
    if self.question_type == "scale"
      self.details['descriptor']
    else
      raise "This question does not have a descriptor component"
    end
  end

  def max_scale_value
    if self.question_type == "scale"
      self.details['max_val']
    else
      raise "This question does not have a scale component"
    end
  end
end
