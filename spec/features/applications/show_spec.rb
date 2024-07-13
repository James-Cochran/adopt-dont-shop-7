require "rails_helper"

RSpec.describe "the applications show page" do
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
    PetApplication.create!(application: @app1, pet: @pet1)
    PetApplication.create!(application: @app1, pet: @pet2)  
  end

  it "shows the applications show page with all it's attributes" do
    visit "/applications/#{@app1.id}"

    expect(page).to have_content("Applicant Name: #{@app1.name}")
    expect(page).to have_content("Street Address: #{@app1.street_address}")
    expect(page).to have_content("City: #{@app1.city}")
    expect(page).to have_content("State: #{@app1.state}")
    expect(page).to have_content("Zip Code: #{@app1.zip_code}")
    expect(page).to have_content("Description: #{@app1.description}")
    expect(page).to have_content("Status: #{@app1.status}")

    expect(page).to_not have_content(@pet3.name)

    click_link(@pet1.name)
    expect(current_path).to eq "/pets/#{@pet1.id}"

    visit "/applications/#{@app1.id}"

    click_link(@pet2.name)
    expect(current_path).to eq "/pets/#{@pet2.id}"
  end

  # User Story 4
  it "can search for pets to add to the application" do 
    visit "/applications/#{@app1.id}"

    expect(page).to_not have_content("Blue")
    expect(page).to have_content("Add a Pet to This Application")

    fill_in "search_bar", with: "Blue"
    click_button "Submit"

    expect(current_path).to eq "/applications/#{@app1.id}"

    expect(page).to have_content("Blue")
  end
end