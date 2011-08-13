require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get 'signup'
      response.should be_success
    end

    it "should have the right title" do
      get 'signup'
      response.should have_selector("title", :content => "Sign up")
    end
    
    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "should have the user name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    
    it "should have a profile name" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

  end

end
