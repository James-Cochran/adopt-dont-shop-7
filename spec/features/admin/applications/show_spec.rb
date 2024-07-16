require "rails_helper"

RSpec.describe "the admin applications show page" do
  before(:each) do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Not So Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet3 = Pet.create!(name: "Blue", age: 3, breed: "Blue Dog", adoptable: true, shelter_id: @shelter.id)
    @app1 = Application.create!(name: "Shaggy",
                                street_address: "1234 Bobs rd",
                                city: "Denver",
                                state: "Colorado",
                                zip_code: "80220",
                                description: "I want a dog!",
                                status: "In Progress")
    @app2 = Application.create!(name: "Fred",
                                street_address: "1234 Fred rd",
                                city: "Boulder",
                                state: "Colorado",
                                zip_code: "80221",
                                description: "I NEED a dog!",
                                status: "In Progress")
    PetApplication.create!(application: @app1, pet: @pet1)
    PetApplication.create!(application: @app1, pet: @pet2) 
  end
  describe "as a visitor, when I visit the admin application show page" do 
    it "there is a functional button to approve next to every pet on the application" do
      visit "/admin/applications/#{@app1.id}"
      # save_and_open_page
      within("#pet-#{@pet1.id}") do
        click_button "Approve This Pet"
      end

      # save_and_open_page

      within("#pet-#{@pet1.id}") do
        expect(page).to_not have_content("Approve This Pet")
        expect(page).to have_content("Approved!")
      end
    end
  end
end