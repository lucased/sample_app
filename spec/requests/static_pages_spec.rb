require 'spec_helper'

describe "StaticPages" do

	describe "Home Page" do

		it "it shoudld have content 'Sample App" do
			visit '/static_pages/home'
			expect(page).to have_content('Sample App')
		end

		it "should have title 'Home'" do
			visit '/static_pages/home'
			expect(page).to have_title('Home')
		end
	end

	describe "Help Page" do

		it "It should have content 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end

		it "should have title 'Helo'" do
			visit '/static_pages/help'
			expect(page).to have_title('Help')
		end
	end

	describe "About Page" do

		it "it should have content 'About Us'" do
			visit '/static_pages/about'
			expect(page).to have_content('About Us')
		end

		it "should have title 'About'" do
			visit '/static_pages/about'
			expect(page).to have_title('About')
		end
	end

end
