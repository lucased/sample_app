require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "Sign in page" do
    before { visit signin_path }

    it { should have_title("Sign In") }
    it { should have_content("Sign In") }

  end

  describe "Sign In" do
    before { visit signin_path }
    let(:submit) { "Sign In" }

    describe "with invalid information" do
      before { click_button submit }

      it { should have_title("Sign In") }
      it { should have_selector('div.alert.alert-danger') }

      describe "after clicking another page" do
        before { click_link "Home" }

        it { should_not have_selector('div.alert.alert-danger') }
      end

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        valid_signin(user)
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',   href: user_path(user)) }
      it { should have_link("Settings") }
      it { should have_link('Sign Out',  href: signout_path) }

      describe "followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end

    end
  end
end
