require 'date'
class TutorsController < ApplicationController
  before_action :set_tutor, only: [:show, :edit, :update, :find_students]
  before_action :check_student_logged_in, except: [:index, :new, :create, :confirm_meeting]

  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all
  end

  def finish_meeting
    @meeting = Meeting.find_by_id(params[:meeting_id])
    @eval = Evaluation.create()
    QuestionTemplate.ordered_list_of_question_templates.each do |qt|
      if qt.is_active
        Question.create(evaluation_id: @eval.id, question_template_id: qt.id, prompt: qt.prompt, is_admin_only: qt.is_admin_only)
      end
    end
    @meeting.update!(is_done: true, evaluation_id: @eval.id)

    tid = params[:tutor_id]
    sid = @meeting.tutee_id

    begin
      TutorMailer.meeting_complete_notice(tid, sid).deliver_now
    rescue StandardError
      flash[:alert] = "An error occured when sending out emails."
    else
      flash[:notice] = "Your meeting was successfully finished."
    end

    redirect_back(fallback_location:"/")
  end

  def delete_meeting
    meeting = Meeting.find_by_id(params[:meeting_id])
    #open request for tutee and for other tutors
    meeting.request.update(status: "open")
    meeting.destroy()

    flash[:notice] = "Your meeting was successfully cancelled."
    redirect_back(fallback_location:"/")
  end

  def confirm_meeting
    @meeting = Meeting.find(params["meeting_id"])
    @tutor_id = params["tutor_id"]
    @tutee_id = @meeting.tutee_id
    @request_id = @meeting.request_id
    @time = Time.strptime(params["meeting_date"] + params["meeting_time"], "%Y-%m-%d%H:%M")
    @loc = params["meeting_location"]

    tutor_message = "Hi, your meeting has been confirmed for " + @time.strftime("%A, %b %d at %l:%M %p") + " at " + @loc + "."

    begin
      TutorMailer.meeting_confirmation(@tutor_id, @tutee_id, tutor_message, @request_id).deliver_now
    rescue StandardError
      flash[:alert] = "An error occured when sending out confirmation emails."
    else
      flash[:notice] = "Successfully confirmed meeting details!"
      @meeting.update(set_time: @time, set_location: @loc, is_scheduled: true);
    end
    redirect_to tutor_path(@tutor_id)
  end

  def match
    tutor_id = params[:tutor_id]
    tutee_email = params[:tutee_email]
    tutee_id = Tutee.find_by_email(tutee_email).id
    request_id = params[:request_id]
    tutor_message = params[:tutor_message]
    begin
      TutorMailer.invite_student(tutor_id, tutee_id, request_id, tutor_message).deliver_now
    rescue StandardError
      flash[:alert] = "An error occured when sending out emails."
    else
      flash[:notice] = "Successfully matched!"
      Meeting.create!(tutor_id: tutor_id, request_id: request_id, tutee_id: tutee_id, is_scheduled:false)
      Request.find(request_id).update(status: 'matched')
    end
    redirect_back(fallback_location:"/")
  end

  def find_students
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    @tutor = Tutor.find_by_id(params[:id])
    @meetings = Meeting.where("tutor_id = ? AND is_done = FALSE", params[:id])
    @previous_meetings = Meeting.where("tutor_id = ? AND is_done = TRUE", params[:id])
  end

  # GET /tutors/new
  def new
    @tutor = Tutor.new
  end

  # GET /tutors/1/edit
  def edit
  end

  # POST /tutors
  # POST /tutors.json
  def create
    @tutor = Tutor.new(tutor_params)
    if params[:classes].blank?
      flash[:notice] = "You must select at least one class."
      redirect_to new_tutor_path
      return
    end
    if @tutor.save
      # flash[:notice] = "#{@tutor.first_name} #{@tutor.last_name} was successfully created."
      respond_to do |format|
        flash[:notice] = "#{@tutor.first_name} #{@tutor.last_name} was successfully created."
        params[:id] = @tutor.id
        format.html { redirect_to tutor_path(@tutor.id)}
      end
    else
      flash[:notice] = "Tutor was not successfully created."
      redirect_to new_tutor_path
    end
  end

  def total_hours
    @tutor= Tutor.find(params[:id])
    return Tutor.total_hours_helper(@tutor)
  end
  helper_method :total_hours


  def hours_this_week
    @tutor= Tutor.find(params[:id])
    return Tutor.hours_this_week_helper(@tutor)
  end
  helper_method :hours_this_week

  def average_hours
    @tutor= Tutor.find(params[:id])
    return Tutor.average_hours_helper(@tutor)
  end
  helper_method :average_hours

  def update
    respond_to do |format|
      if @tutor.update!(tutor_params) && @class_obj.update(classes_params)
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { render :show, status: :ok, location: @tutor }
      else
        format.html { render :edit }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  def requests

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    VALID_EMAIL_REGEX = /A[\w+\-.]+@berkeley.edu/

    def set_tutor
      if params[:id] == "sign_out" || params[:id] == "new"
        redirect_to new_tutor_session_path
      elsif params[:id] == "password"
        redirect_to new_tutor_password_path
      else
        if params[:id]
          @tutor = Tutor.find(params[:id])
        else
          @tutor = Tutor.find(params[:tutor_id])
        end
        @courses = Admin.course_list
      end
    end

    def validate_email (email)
      /\A[\w+\-.]+@berkeley.edu/.match(email)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
      params.require(:tutor).permit(:type_of_tutor, :term, :email, :first_name,
        :last_name, :sid, :gender, :dsp, :transfer, :major)
    end
end
