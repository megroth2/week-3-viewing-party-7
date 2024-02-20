# Viewing Party Lite - Week 3 Version

This repo can be used by any students during BE week 3.

## Set Up

1. fork and clone
2. bundle install
3. rails db:{drop,create,migrate,seed}


## Authentication Challenge
For this challenge, you will be refactoring your Viewing Party Lite project to include basic authentication. Currently on your Viewing Party Lite project, a user 'registers' by providing their name and email. We want to update the registration form to include a password and a password confirmation field, and we want to securely store that user's password upon registration.

**User Story #1 - Registration (w/ Authentication) Happy Path**
  ```
  As a visitor 
  When I visit `/register`
  I see a form to fill in my name, email, password, and password confirmation.
  When I fill in that form with my name, email, and matching passwords,
  I'm taken to my dashboard page `/users/:id`
  Steps for User Story #1:
  Update your user model test - we're going to be updating our user table to hold a secure password, so we should test for that first
  ```

Expand to see some examples of good assertions to make
Get your tests to pass, and check in your rails console
Add Bcrypt and update User table to include password_digest field.

Update existing tests - Now that you've updated the requirements for user creation, you'll notice that all of your tests that create users are failing now. Update this in your tests.

Update test for creating a user - Originally, your app only required name and email. Now, you need to add fields for password and password_confirmation.


**User Story #2 - Registration (w/ Authentication) Sad Path**
  ```
  As a visitor 
  When I visit `/register`
  and I fail to fill in my name, unique email, OR matching passwords,
  I'm taken back to the `/register` page
  and a flash message pops up, telling me what went wrong
  ```

Steps for User Story #2:
Add a Sad Path Test for creating a user
You're going to need to update the logic in your controller action to check if the password AND password_confirmation both came through, and match.

**User Story #3 - Logging In Happy Path**
  ```
  As a registered user
  When I visit the landing page `/`
  I see a link for "Log In"
  When I click on "Log In"
  I'm taken to a Log In page ('/login') where I can input my unique email and password.
  When I enter my unique email and correct password 
  I'm taken to my dashboard page
  ```

Notes for User Story #3:
You will need to create two routes for this user story (one for going to a /login page, and one for actually checking credentials and directing traffic). These routes DO NOT need to be ReSTful right now. We'll talk about how to make them ReSTful tomorrow. For now, you might consider doing something like this:
GET '/login', to: 'users#login_form'
login_form will render login_form.html.erb for users to fill in a form with their credentials
POST '/login', to: 'users#login_user'
login_user will check if a user exists with the email address that was provided, then check to see if the password, when hashed, matches the secure password stored in the database, and then redirects the user based on if credentials are correct.

**User Story #4 - Logging In Sad Path**
  ```
  As a registered user
  When I visit the landing page `/`
  And click on the link to go to my dashboard
  And fail to fill in my correct credentials 
  I'm taken back to the Log In page
  And I can see a flash message telling me that I entered incorrect credentials.
  ```

Notes for User Story #4:
You'll need to add some conditional logic into your login_user method to account for invalid credentials.


## Authorization and Sessions Challenge
For this challenge, focus on using Behavior Driven Development (BDD) over Test Driven Development (TDD).

### Part 1: Cookies Challenge
**1: Implement a Cookie**
  ```
  As a user
  when I go to the login page (/login)
  Under the normal login fields (username, password)
  I also see a text input field for "Location"
  When I enter my city and state in this field (e.g. "Denver, CO")
  and successfully log in
  I see my location on the landing page as I entered it.

  Then, when I log out and return to the login page
  I still see my location that I entered previously 
  already typed into the Location field. 
  ```

Note:
To accomplish this story, do not create a new field in your user table. Instead, store this data in a cookie and use that cookie value in your views.
Consider the pros/cons of using a plaintext vs. signed vs. encrypted cookie for this data in particular.
Think: Why would we want to store this data in a cookie, and not in a session or database?

### Part 2: Sessions Challenge
**2: Remember a user upon successful log in/registration**
In your users#create action, and your users#login_user (or sessions#create if you've refactored) action, add that authenticated user's id into the session session[:user_id] = user.id.
  ```
  As a user
  when I log in successfully
  and then leave the website and navigate to a different website entirely,
  Then when I return to *this* website, 
  I see that I am still logged in. 
  ```
**3: Log out a user**
  ```
  As a logged-in user 
  When I visit the landing page
  I no longer see a link to Log In or Create an Account
  But I only see a link to Log Out.
  When I click the link to Log Out,
  I'm taken to the landing page
  And I see that the Log Out link has changed back to a Log In link
  And I still see the Create an Account button. 
  ```
  
Steps to consider
Add a conditional in your view to show the correct Link (Remember, you can access session data in your views)
Create a new route for logging out
This action should remove the user_id key from the session so that the user id doesn't persist.

### Part 3: Authorization Challenge
**4: Logged-out users see limited info on Landing Page**
  ```
  As a visitor
  When I visit the landing page
  I do not see the section of the page that lists existing users
  ```

**5: Logged-in users no longer see links on Landing Page**
  ```
  As a logged-in user
  When I visit the landing page 
  The list of existing users is no longer a link to their show pages
  But just a list of email addresses
  ```
  Note: this story isn't necessarily 'authorization', this functionality is just not necessary anymore, now that we have basic auth in place.

**6: Dashboard Authorization**
  ```
  As a visitor
  When I visit the landing page
  And then try to visit the user's dashboard ('/users/:user_id')
  I remain on the landing page
  And I see a message telling me that I must be logged in or registered to access a user's dashboard.
  ```
  
**7: Create a Viewing Party Authorization**
  ```
  As a visitor
  If I go to a movies show page ('/users/:user_id/movies/:movie_id')
  And click the button to Create a Viewing Party
  I'm redirected back to the movies show page, and a message appears to let me know I must be logged in or registered to create a Viewing Party. 
  ```

