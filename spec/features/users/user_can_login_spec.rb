require 'rails_helper'

RSpec.describe "User registration form" do

  before(:each) do
    @user_1 = User.create(name: "User One", email: "user1@test.com", password: "123", password_confirmation: "123")

    visit login_path
  end

  describe "happy paths" do
    it "logs in user" do
      fill_in :email, with: "user1@test.com"
      fill_in :password, with: "123"
    
      click_button "Log In"

      expect(current_path).to eq(user_path(@user_1))
    end
  end

  describe "sad paths" do
    it "does not log in user - bad password" do
      fill_in :email, with: "user1@test.com"
      fill_in :password, with: "wrongpassword"
    
      click_button "Log In"

      expect(current_path).to eq(login_path)
    end

    it "does not log in user - bad username" do
      fill_in :email, with: "wrong@email.com"
      fill_in :password, with: "123"
    
      click_button "Log In"

      expect(current_path).to eq(login_path)
    end
  end
end