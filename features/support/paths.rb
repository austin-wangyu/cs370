
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the public edit page with feedback "(.*)"$/
      p Evaluation.all
      @allevals = Evaluation.all
      @eval1 = Evaluation.new()
      @allevals.each do |eval|
        if eval.feedback == ($1)
          hash = eval.hash_id
          @eval1 = eval.clone
          p hash
        end
      end
      edit_evaluation_path(@eval1)

    when /^the home\s?page$/
      '/'

####USERS
    when /the dashboard/
      dashboard_path
    when /the user registration page/
      new_user_registration_path
####TUTEES
####TUTORS
####ADMINS
    when /the admin login page/
      new_admin_session_path
    when /the manage semester page/
      admin_manage_semester_path
    when /the update admin password/
      admin_update_password_path
    when /the update priorities page/
      admin_update_student_priorities_path
    when /the rating tutors page/
      admin_rating_tutors_path
    when /the tutor hours page/
      admin_tutor_hours_path
    when /the admin home page/
      admin_home_path
    when /the manage tutors page/
      admin_manage_tutors_path


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      puts "Can't find mapping"
    end
  end
end

World(NavigationHelpers)
