include ApplicationHelper

def valid_signin(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
  else
    visit signin_path
    fill_in "session_email", with: user.email
    fill_in "session_password", with: user.password
    click_button "Sign In"
  end
end

def valid_signup
  fill_in "Name", 					with: "Example User"
  fill_in "Email",					with: "user@example.com"
  fill_in "Password", 			with: "foobar"
  fill_in "Password confirmation",	 with: "foobar"
end
