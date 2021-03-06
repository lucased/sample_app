require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe "Signup Page" do

		before { visit signup_path }

		it { should have_content('Sign Up') }
		it { should have_title(full_title('Sign Up')) }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_content(user.name) }
		it { should have_title(user.name) }
	end

	describe "Sign Up" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.to_not change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_title(full_title("")) }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				valid_signup
			end

			it "should create a new user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'user@example.com') }

				it { should have_link("Sign Out") }
				it { should have_title(user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end
		end
	end

	describe "index" do
		before do
			valid_signin FactoryGirl.create(:user)
			FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
			FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
			visit users_path
		end

		it { should have_title('All users') }
		it { should have_content('All users') }

		describe "pagination" do

			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			it { should have_selector('div.pagination') }

			it "should list each user" do
				User.paginate(page: 1).each do |user|
					expect(page).to have_selector('li', text: user.name)
				end
			end
		end

		describe "delete link" do
			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
					valid_signin admin
					visit users_path
				end

				it { should have_link("delete", href: user_path(User.first)) }
				it "should be able to delete another user" do
					expect do
						click_link("delete", match: :first)
					end.to change(User, :count).by(-1)
				end
				it { should_not have_link('delete', href: user_path(admin)) }
			end
		end

		describe "edit" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				valid_signin user
				visit edit_user_path(user)
			end

			describe "page" do
				it { should have_title("Edit User") }
				it { should have_content("Update your profile") }
				it { should have_link("Change", href: "http://gravatar.com/emails") }
			end

			describe "with invalid information" do
				before { click_button "Save Changes" }
				it { should have_content("error") }
			end

			describe "with valid information" do
				let(:new_name) { "New Name" }
				let(:new_email) { "new@example.com" }
				before do
					fill_in "Name", 									with: new_name
					fill_in "Email",									with: new_email
					fill_in "Password",	 						with: user.password
					fill_in "Password confirmation",	with: user.password
					click_button "Save Changes"
				end

				it { should have_title(new_name) }
				it { should have_selector('div.alert.alert-success', text: "Profile Updated") }
				it { should have_link("Sign Out", href: signout_path) }
				specify { expect(user.reload.name).to eq new_name }
				specify { expect(user.reload.email).to eq new_email }
			end
		end

	end
end
