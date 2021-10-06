QuestionTemplate.create!(:prompt=>"What did you like about how your tutor covered the material?",
  :is_optional=>false, :question_type=>"text", :order=>1, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 20})
QuestionTemplate.create!(:prompt=>"What is the best thing that your tutor did?",
  :is_optional=>false, :question_type=>"text", :order=>2, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 20})
QuestionTemplate.create!(:prompt=>"What is something your tutor could work to improve?",
  :is_optional=>false, :question_type=>"text", :order=>3, :is_active=>true, :is_admin_only=>false, :details=>{:min_char => 20})
QuestionTemplate.create!(:prompt=>"How knowledgeable was your tutor?",
  :is_optional=>false, :question_type=>"scale", :order=>4, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Knowledgeable', :max_val => 10, :max_lab => "Very Knowledgeable", :descriptor => "Knowledgeable"})
QuestionTemplate.create!(:prompt=>"How supportive was your tutor?",
  :is_optional=>false, :question_type=>"scale", :order=>5, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Supportive', :max_val => 10, :max_lab => "Very Supportive", :descriptor => "Supportive"})
QuestionTemplate.create!(:prompt=>"How clear were your tutor's explanations?",
  :is_optional=>false, :question_type=>"scale", :order=>6, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Not Clear', :max_val => 10, :max_lab => "Very Clear", :descriptor => "Clarity"})
QuestionTemplate.create!(:prompt=>"How was the pacing of the appointment?",
  :is_optional=>false, :question_type=>"scale", :order=>7, :is_active=>true, :is_admin_only=>false, :details=>{:min_val => 1, :min_lab => 'Too Slow', :max_val => 10, :max_lab => "Too Fast", :descriptor => "Pacing"})
QuestionTemplate.create!(:prompt=>"Any other concerns?",
  :is_optional=>true, :question_type=>"text", :order=>8, :is_active=>true, :is_admin_only=>true, :details=>{:min_char => 0})

admin_password = BCrypt::Password.create(Admin.general_seed_password)
Admin.create(id:1, password_digest:admin_password)

#use Admin.general_seed_password for reliability, single source of truth. All users have the same password for testing purposes.
Tutee.create( #user 1
  first_name: "Tutee", last_name: "Demo", email: "tutee@berkeley.edu", gender: "Male", pronoun: "He/His",
  ethnicity: ['Vietnamese'], major: 'Intended Computer Science', dsp: false, transfer: false, term: "8",
  password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
Tutee.create(
  first_name: "Alice", last_name: "Demo", email: "alice@berkeley.edu", gender: "Non-Binary", pronoun: "Other",
  ethnicity: ['White', 'Black or African American'], major: 'Declared Data Science', dsp: false, transfer: true, term: "4",
  password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")
Tutee.create(
  first_name: "Bob", last_name: "Demo", email: "bob@berkeley.edu", gender: "Female", pronoun: "She/Hers",
  ethnicity: ['Chinese', 'White'], major: 'Intended Cognitive Science', dsp: false, transfer: false, term: "2", has_priority: true,
  password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")

Tutor.create( #user 4
  first_name: "Tutor", last_name: "Demo", email: "tutor@berkeley.edu", gender: "Male", pronoun: "He/His",
  ethnicity: ['Chinese'], major: 'Declared Computer Science', dsp: false, transfer: true, term: "4",
  password: Admin.general_seed_password, password_confirmation: Admin.general_seed_password, confirmed_at: "2021-05-07 05:07:48")

#3 past meetings that have occurred between Tutor and all three Tutees
Request.create(:user_id=>"1",:course=>"CS61A",:meeting_length=>2,:subject=>"environment diagrams", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Meeting.create(:tutor_id=>"4", :request_id=>"1", set_time: "Fri, 01 Oct 2021 14:07:00 PDT -07:00", set_location: "Moffitt 3rd Floor", status: "finished")
Evaluation.create(meeting_id: "1", :took_place=>true, :status=>"complete", :hours=>1)

Request.create(:user_id=>"2",:course=>"CS88",:meeting_length=>2,:subject=>"data analysis and ETL", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Meeting.create(:tutor_id=>"4", :request_id=>"2", set_time: "Sun, 03 Oct 2021 16:24:00 PDT -07:00", set_location: "Main Stacks", status: "finished")
Evaluation.create(meeting_id: "2", :took_place=>true, :status=>"complete", :hours=>5)

Request.create(:user_id=>"3",:course=>"CS70",:meeting_length=>2,:subject=>"dynamic programming and exam prep", :status=>"matched", :created_at=>"2021-04-01 12:58:45 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Meeting.create(:tutor_id=>"4", :request_id=>"3", set_time: "Tue, 05 Oct 2021 20:30:00 PDT -07:00", set_location: "The nearest hole in the ground", status: "finished")
Evaluation.create(meeting_id: "3", :took_place=>true, :status=>"complete", :hours=>3)

#Bob requests 61A tutoring
Request.create(:user_id=>"3",:course=>"CS10",:meeting_length=>1,:subject=>"scratch help, for loops", :status=>"open", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")

#Meeting proposed for Alice by Tutor
Request.create(:user_id=>"2",:course=>"CS61A",:meeting_length=>1,:subject=>"env diags and inheritance", :status=>"matched", :created_at=>"2021-04-01 12:58:46 -0700", :updated_at=>"2021-04-01 12:58:45 -0700")
Meeting.create(:tutor_id=>"4", :request_id=>"5")
