include ApplicationHelper

def valid_signin(user)
  fill_in "session_email", with: user.email
  fill_in "session_password", with: user.password
  click_button "Sign In"
end
