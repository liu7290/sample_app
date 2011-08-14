require 'spec_helper'

describe "Users" do
  describe "singup" do
    describe "failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",  :with => ""
          fill_in "Email",  :with => ""
          fill_in "Password",  :with => ""
          fill_in "Password confirmation",  :with => ""
          click_button "Sign up"
          response.should render_template('signup')
          response.should have_selector("div#error_explanations")
        end.should_not change(User, :count)
      end
    end
  end
end
