require 'spec_helper'

describe "StaticPages" do

	let(:base_title) {"Ruby on Rails Tutorial Sample App"}

	describe "Home Page" do

		it "it shoudld have content 'Sample App" do
			visit '/static_pages/home'
			expect(page).to have_content('Sample App')
		end

		it "should have the base title" do
			visit '/static_pages/home'
			expect(page).to have_title("#{base_title}")
		end

		it "shoud not have title 'home'" do
			visit '/static_pages/home'
			expect(page).not_to have_title('Home')
		end
	end

	describe "Help Page" do

		it "It should have content 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end

		it "should have title 'Helo'" do
			visit '/static_pages/help'
			expect(page).to have_title("#{base_title} | Help")
		end
	end

	describe "About Page" do

		it "it should have content 'About Us'" do
			visit '/static_pages/about'
			expect(page).to have_content('About Us')
		end

		it "should have title 'About'" do
			visit '/static_pages/about'
			expect(page).to have_title("#{base_title} | About Us")
		end
	end

	describe "Contact Page" do

		it "should have content 'Contact'" do
			visit '/static_pages/contact'
			expect(page).to have_content('Contact')
		end

		it "should have title 'Contact'" do
			visit '/static_pages/contact'
			expect(page).to have_title("#{base_title} | Contact")
		end
	end

	describe "Store Page" do

		it "should have content 'Store'" do
			visit '/static_pages/store'
			expect(page).to have_content('Store')
		end
	end

end
