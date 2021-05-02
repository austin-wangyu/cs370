class AdminsController < ApplicationController
  layout 'admin_layout', :only => [:home, :update_semester, :updateCurrentSemester, :rating_tutors, :update_courses, :tutor_hours, :update_password, :update_student_priorities, :manage_tutors, :manage_semester, :update_question_templates]
  before_action :set_admin, except: [:landing, :destroyAdminSession]
  before_action :check_logged_in, except: [:landing, :createAdminSession, :destroyAdminSession]

  def landing
  end

  def export_table
    require 'zip'
    require 'tempfile'

    @tutors = Tutor.all
    @evaluations = Evaluation.all

    case params[:query]
    when "all"
      zip_all_tables
    when "tutor_hours"
      send_data @tutors.hours_to_csv, filename: "tutor-hours-#{Date.today}.csv"
    when "tutor_ratings"
      send_data @tutors.ratings_to_csv, filename: "tutor-ratings-#{Date.today}.csv"
    when "demographic_hours"
      send_data @evaluations.hours_demographic_to_csv, filename: "demographic-hours-#{Date.today}.csv"
    when "course_hours"
      send_data @evaluations.hours_course_to_csv, filename: "course-hours-#{Date.today}.csv"
    end

  end

  def zip_all_tables
    date = Date.today
    filename = "cs370-#{date}-data.zip"
    temp_file = Tempfile.new(filename)
    inner_filenames = [["tutors-#{date}.csv", Tutor.to_csv],
      ["tutees-#{date}.csv",Tutee.to_csv],
      ["meetings-#{date}.csv", Meeting.to_csv],
      ["evaluations-#{date}.csv", Evaluation.to_csv],
      ["courses-#{date}.csv",Course.to_csv]]
    begin
      #Initialize the temp file as a zip file
      Zip::OutputStream.open(temp_file) { |zos| }

      #Add files to the zip file as usual
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        #Put files in here
        inner_filenames.each do |inner|
          zip.get_output_stream(inner[0]) { |f| f.puts inner[1] }
        end
      end

      #Read the binary data from the file
      zip_data = File.read(temp_file.path)

      #Send the data to the browser as an attachment
      #We do not send the file directly because it will
      #get deleted before rails actually starts sending it
      send_data(zip_data, :type => 'application/zip', :filename => filename)
    ensure
      #Close and delete the temp file
      temp_file.close
      temp_file.unlink
    end
  end

  def tutor_hours
    @admin = Admin.find(Admin.master_admin_index)
    @current_semester = Admin.current_semester_formatted
    @tutors = Tutor.all
    @meeting = Meeting.all
    @evaluations = Evaluation.all
    @courses = Course.where(:active => true)
    #TODOAUSTIN temporary fix, wait for chris to respond on how he wants mutli-ethnic reporting to be weighted, then implement.
    @demographics = Tutee.distinct.pluck(:ethnicity) + ['Male','Female','Non-Binary']
  end

  def manage_tutors
    @tutors = Tutor.all
  end

  def delete_tutor
    email = params[:delete_tutor][:email]
    tutor_to_delete = Tutor.where(:email => email).first
    if tutor_to_delete.nil?
      flash[:notice] = "No tutor with email #{email} exists."
    else
      flash[:message] = "Tutor #{email} successfully deleted."
      meetings_to_delete = Meeting.where(:tutor => tutor_to_delete).delete_all
      tutor_to_delete.destroy
    end
    redirect_to admin_manage_tutors_path
  end

  def createAdminSession
    @admin = Admin.find(Admin.master_admin_index)
    if @admin and @admin.authenticate(params[:password])
      session[:admin_logged_in] = true
      redirect_to admin_home_path
    else
      redirect_to homepage_path
    end
  end

  def destroyAdminSession
    session[:admin_logged_in] = false
    redirect_to homepage_path
  end

  def home
    @semester_options = Admin.semester_possibilities
    @current_semester = Admin.current_semester_formatted
  end

  def manage_semester
    @semester_options = Admin.semester_possibilities
    @current_semester = Admin.current_semester_formatted
    @signups_allowed = Admin.signups_allowed
    @tutor_types = Admin.tutor_types
    @tables = ["Tutors", "Tutees", "Requests", "Meetings", "Evaluations", "Courses"]
  end

  def toggle_signups
    @admin.update(signups_allowed: !Admin.signups_allowed)
    if Admin.signups_allowed
      flash[:message] = "Signups have been turned on."
    else
      flash[:message] = "Signups have been turned off."
    end
    redirect_to admin_manage_semester_path
  end

  def update_tutor_types
    @admin.update(tutor_types: params[:tutor_types])
  end

  def close_unmatched_requests
    Request.all.each do |request|
      if !request.matched?
        request.update(:closed => true)
      end
    end
    flash[:message] = "All unmatched requests have been closed."
    redirect_to admin_manage_semester_path
  end

  def updateCurrentSemester
    if not params[:update_current_semester].nil?
      c_sem, c_year = updateSemesterHelper(:update_current_semester)
    end
    if not c_sem.nil? and not c_year.nil? and Admin.validate_year(c_year)
      # also update the courses along with updating the semester
      flash[:message] = "Current semester was successfully updated."
      @old_semester_courses = Course.current_courses_formatted
      @admin.update(:current_semester => c_sem + c_year)
      Course.update_courses(@old_semester_courses) # relies on the current semester so should auto populate the new semester with the old courses
    else
      flash[:notice] = "Error updating current semester, year is likely mistyped"
    end
    redirect_to admin_manage_semester_path
  end

  def rating_tutors
    @tutors = Tutor.all
  end

  def updateSemesterHelper val
    return params[val][:semester], params[val][:year]
  end

  def update_password

  end

  def post_update_password
    password, confirmation_password = params[:update_password][:password], params[:update_password][:password_confirmation]
    if password == confirmation_password
      if @admin.update(:password => password)
        flash[:message] = "Admin password successfully updated."
      end
    else
      flash[:notice] = "Passwords do not match"
    end
    redirect_to admin_update_password_path
  end


  def update_question_templates
    @question_templates = QuestionTemplate.ordered_list_of_question_templates
  end

  private

  def check_logged_in
    if session[:admin_logged_in].nil? or not session[:admin_logged_in]
      redirect_to homepage_path
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(Admin.master_admin_index)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:admin).permit(:password, :password_confirmation, :statistics_semester, :current_semester)
  end


end
