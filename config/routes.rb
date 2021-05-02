Rails.application.routes.draw do

  devise_for :tutors, controllers: {registrations: 'tutors/registrations'}, skip:['sessions']
  devise_for :tutees, skip:['registrations','sessions']
  devise_scope :tutor do
    get '/' => 'welcome#index', as: :new_tutor_session
    post '/tutors/sign_in' => 'devise/sessions#create', as: :tutor_session
    delete '/tutors/sign_out' => 'devise/sessions#destroy', as: :destroy_tutor_session
  end

  devise_scope :tutee do
    get '/' => 'welcome#index', as: :new_tutee_session
    post '/tutees/sign_in' => 'devise/sessions#create', as: :tutee_session
    delete '/tutees/sign_out' => 'devise/sessions#destroy', as: :destroy_tutee_session

    #TODO: try to move tutee account editing out of devise/registration's domain, and into tutee#edit
    get '/tutees/cancel' => 'tutees/registrations#cancel', as: :cancel_tutee_registration
    get '/tutees/sign_up' => 'tutees/registrations#new', as: :new_tutee_registration
    get '/tutees/:id/edit' => 'tutees/registrations#edit', as: :edit_tutee_registration
    patch '/tutees/:id' => 'tutees/registrations#update', as: :tutee_registration
    put '/tutees/:id' => 'tutees/registrations#update'
    post '/tutees/' => 'tutees/registrations#create'

  end

  #resources :admins
  root "welcome#index", as: :homepage
  get '/welcome/get_login_form/' => 'welcome#get_login_form', as: :welcome_get_login_form
  get '/tutors/:tutor_id/find_students' => 'tutors#find_students', as: :tutor_find_students
  get '/tutors/:tutor_id/requests/email/' => 'requests#email', as: :requests_email_tutor
  post '/tutors/:tutor_id/meetings/:meeting_id/done' => 'meetings#done', as: :meetings_done

  get 'admins/home' => 'admins#home', as: :admin_home
  post '/' => 'admins#createAdminSession', as: :admin_login
  get '/' => 'admins#destroyAdminSession', as: :admin_logout
  get 'admins/manage_semester' => 'admins#manage_semester', as: :admin_manage_semester
  get 'admins/toggle_signups' => 'admins#toggle_signups', as: :admin_toggle_signups
  get 'admins/close_unmatched_requests' => 'admins#close_unmatched_requests', as: :admin_close_unmatched_requests
  post 'admins/current_semester_update' => 'admins#updateCurrentSemester', as: :admin_update_current_semester
  post 'admins/update_tutor_types' => 'admins#update_tutor_types', as: :admin_update_tutor_types

  get 'admins/rating_tutors' => 'admins#rating_tutors', as: :admin_rating_tutors
  get 'admins/tutor_hours' => 'admins#tutor_hours', as: :admin_tutor_hours
  get 'admins/manage_tutors' => 'admins#manage_tutors', as: :admin_manage_tutors
  post 'admins/manage_tutors/delete_tutor' => 'admins#delete_tutor', as: :admin_delete_tutor
  get 'admins/export_table' => 'admins#export_table', as: :admin_export_table
  # post 'admins/statistics_semester_update' => 'admins#updateStatisticsSemester', as: :admin_update_statistics_semester
  get 'admins/courses_update' => 'admins#update_courses', as: :admin_update_courses
  post 'admins/courses_update' => 'admins#post_update_courses', as: :admin_post_update_courses
  get 'admins/update_password' => 'admins#update_password', as: :admin_update_password
  post 'admins/update_password' => 'admins#post_update_password', as: :admin_post_update_password

  get 'admins/update_student_priorities' => 'admins#update_student_priorities', as: :admin_update_student_priorities
  post 'admins/update_student_priorities_61A' => 'admins#update_student_priorities_61A', as: :admin_update_student_priorities_61A
  post 'admins/update_student_priorities_61B' => 'admins#update_student_priorities_61B', as: :admin_update_student_priorities_61B
  post 'admins/update_student_priorities_61C' => 'admins#update_student_priorities_61C', as: :admin_update_student_priorities_61C
  post 'admins/update_student_priorities_70' => 'admins#update_student_priorities_70', as: :admin_update_student_priorities_70

  #TODOAUSTIN delete this comment if the below works
  get 'admins/update_question_templates' => 'admins#update_question_templates', as: :admin_update_question_templates
  post 'admins/batch_update' => 'question_templates#batch_update', as: :question_templates_batch_update
  get 'question_templates/get_details' => 'question_templates#get_details'
  get 'question_templates/new' => 'question_templates#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, except: [:index, :create, :edit, :new, :update]
  resources :courses, :requests
  resources :evaluations, only: [:update, :destroy]
  resources :tutees do
    resources :requests, except: [:index, :email, :show]
    resources :meetings
    resources :evaluations
  end

  get 'tutees/login/:id' => 'tutees#createTuteeSession', as: :login_tutee

  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee

  get 'evaluations/:id' => 'evaluations#public_show', as: :evaluation_public
  get 'evaluations/:id/edit' => 'evaluations#public_edit', as: :edit_evaluation

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tutors, except: [:index, :create, :edit, :new, :update]
  resources :tutors do
    resources :requests, except: [:index, :show, :new, :update]
  end
end
