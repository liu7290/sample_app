require 'spec_helper'

describe "LayoutLinks" do
  
  describe "it should have a home page at /" do
    it "should be successful" do
      get '/'
      response.should have_selector('title', :content => "Home")
    end
  end

  describe "it should have a home page at /contact" do
    it "should be successful" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end
  end

  describe "it should have a home page at /about" do
    it "should be successful" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end
  end

  describe "it should have a home page at /help" do
    it "should be successful" do
      get '/help'
      response.should have_selector('title', :content => "Help")
    end
  end

end
