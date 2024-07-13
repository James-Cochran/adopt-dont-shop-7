require "rails_helper"

RSpec.describe "application creation" do
    it "creates a new application" do
        
        visit "/applications/new"
        save_and_open_page
        expect(page).to have_content("Applicant Name")
        expect(page).to have_content("Street Address")
        expect(page).to have_content("City")
        expect(page).to have_content("State:")
        expect(page).to have_content("Zip Code")
        expect(page).to have_content("Description")
    
    end
end