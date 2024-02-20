require 'rails_helper'

RSpec.describe "User registration form" do

  before(:each) do
    visit register_path
  end

  describe "happy paths" do
    it "creates new user" do
      name = "jerry"
      email = "jerry@gmail.com"
      password = "test"
      password_confirmation = "test"

      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation

      click_on "Create New User"

      expect(current_path).to eq(user_path(User.last.id))
    end
  end

  describe "sad paths" do
    it "password and password confirmation do not match" do
      name = "jerry"
      email = "jerry@gmail.com"
      password = "test"
      password_confirmation = "t"

      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation

      click_on "Create New User"

      expect(page).to have_content("Password and password confirmation do not match.")
      expect(current_path).to eq(register_path)
    end

    it "name is blank" do
      email = "jerry@gmail.com"
      password = "test"
      password_confirmation = "test"

      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation

      click_on "Create New User"

      # expect(page).to have_content("") # Error
      expect(current_path).to eq(register_path)
    end

    it "email is blank" do
      name = "jerry"
      password = "test"
      password_confirmation = "test"

      fill_in :user_name, with: name
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation

      click_on "Create New User"

      # expect(page).to have_content("") # Error
      expect(current_path).to eq(register_path)
    end

    it "password is blank" do
      name = "jerry"
      email = "jerry@gmail.com"
      password_confirmation = "test"

      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password_confirmation, with: password_confirmation

      click_on "Create New User"

      # expect(page).to have_content("") # Error
      expect(current_path).to eq(register_path)
    end

    it "password confirmation is blank" do
      name = "jerry"
      email = "jerry@gmail.com"
      password = "test"

      fill_in :user_name, with: name
      fill_in :user_email, with: email
      fill_in :user_password, with: password

      click_on "Create New User"

      # expect(page).to have_content("") # Error
      expect(current_path).to eq(register_path)
    end
  end
end