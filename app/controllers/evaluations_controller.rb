class EvaluationsController < ApplicationController

  def view_responses
    meeting = Meeting.find(params['meeting_id'])
    evaluation = meeting.evaluation
    if evaluation.status == "pending"
      return render json:{partial: render_to_string(partial: "evaluations/not_yet_complete")}
    else
      return render json:{partial: render_to_string(partial: "evaluations/question_responses", locals: {evaluation: evaluation, user: 'tutor'})}
    end
  end

  def update
    @evaluation = Evaluation.find params[:id]
    took_place = (params['hours'].to_d > 0)
    if @evaluation.update(took_place: took_place, course: params['course'], hours: params['hours'], status: "complete")
      flash[:success] = "Evaluation submitted!"
      #in case the tutor hasn't marked it as done yet, tutee submitting an evaluation will.
      @evaluation.meeting.update(status: 'finished')
      params.keys.each do |k|
        if k.include?('response_')
          qid = k.split('_')[1]
          res = took_place ? params[k] : "N/A"
          Question.find(qid).update!(response: res)
        end
      end
    else
      flash[:notice] = "Something went wrong and your evaluation was not saved"
    end
    redirect_to dashboard_path
  end
end
