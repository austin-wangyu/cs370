Given /the following admins exist/ do |admins_table|
  admins_table.hashes.each do |admin|
    Admin.create admin
  end
end

Given /signups are off/ do
  Admin.find(Admin.master_admin_index).update(signups_allowed: false)
end

Then /I can see current semester "(.*)" title/ do |text|
  expect(page).to have_content(text)
end

Then /I can see courses "(.*)"/ do |course_list|
  course_list.to_s.split(", ").each do |course_name|
    expect(page).to have_content(course_name)
  end
end

Then /I can not see course "(.*)"/ do |course|
  expect(page).to have_no_content(course)
end

Then /I can see tutor "(.*)" with tutor hours (.*)/ do |first,num|
  expect(page).to have_content(first)
  expect(page).to have_content(num)
end


Then /I can see course "(.*)" only once/ do |course|
  expect(page).to have_content(course, maximum: 1)
end

When /I make an update for courses to "(.*)"/ do |course_list|
  obj = page.find(:xpath, '//*[@id="update_courses_courses"]',visible: false)
  # separate course list into a newline separated list rather than comma separated
  obj.set(course_list.to_s.gsub(/, /, "\r\n"))
  # fill_in obj.field, with: course_list.to_s.gsub(/,/, "/r/n")
  click_button("update_courses")
end

When /I update admin password with password "(.*)" and confirmation password "(.*)"/ do |pass, confirmation|
  page.find(:xpath, '//*[@id="update_password_password"]').set(pass)
  page.find(:xpath, '//*[@id="update_password_password_confirmation"]').set(confirmation)
  click_button("update_password")
end

Then /I can see the tutor name "(.*)"/ do |name|
  expect(page).to have_content(name)
end

Then /I can see the composite score of "(.*)"/ do |score|
  expect(page).to have_content(score)
end

Then /I can see sids "(.*)"/ do |sid_list|
  sid_list.to_s.split(", ").each do |sid|
    expect(page).to have_content(sid)
  end
end
Then /I can not see sid "(.*)"/ do |sid|
  expect(page).to have_no_content(sid)
end
