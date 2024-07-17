require "rails_helper"

# User Story 10
RSpec.describe "the admin shelters index page" do
    it "shows all the shelters in desending alphabetical order" do
        shelter1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
        shelter2 = Shelter.create!(name: "Fred and Daphne's Super Shelter", city: "Irvine CA", foster_program: false, rank: 10)
        shelter3 = Shelter.create!(name: "Velma's Pet Emporium", city: "Irvine CA", foster_program: false, rank: 7)

        visit '/admin/shelters'
        
        expect(shelter3.name).to appear_before(shelter1.name)
        expect(shelter3.name).to appear_before(shelter2.name)
        expect(shelter1.name).to appear_before(shelter2.name)
        
        expect(page).to have_content("Fred and Daphne's Super Shelter")
        expect(page).to have_content("Mystery Building")
        expect(page).to have_content("Velma's Pet Emporium") 
    end
end