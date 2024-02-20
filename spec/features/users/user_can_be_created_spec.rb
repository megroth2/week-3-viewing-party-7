require 'rails_helper'

RSpec.describe "User registration form" do
  describe "happy paths" do
    it "creates new user" do
      visit register_path

      name = "jerry"
      email = "jerry@gmail.com"
      password = "test"
      password_confirmation = "test"

      fill_in 'user[name]', with: name
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password_confirmation

      click_on "Create New User"

      
      expect(current_path).to eq(user_path(User.last.id))
    end
  end

  describe "sad paths" do
    it "password and password confirmation do not match" do
      visit register_path

      name = "jerry"
      email = "jerry@gmail.com"
      password = "test"
      password_confirmation = "t"

      fill_in 'user[name]', with: name
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password_confirmation

      click_on "Create New User"

      expect(page).to have_content("Password and password confirmation do not match.")
      expect(current_path).to eq(register_path)
    end
  end
end