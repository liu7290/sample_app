require 'spec_helper'

describe PagesController do
  render_views
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    
    it 'should have the right title' do
      get 'home'
      response.body.should contain('Home')
    end
    
    it 'should have a non-blank body' do
      get 'home'
      response.body.should_not  =~ /<body>\s*<\/body>/
    end
  end
  
  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it 'should have the right title' do
      get 'about'
      response.body.should contain('About')
    end
  end
  
  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it 'should have the right title' do
      get 'contact'
      response.body.should contain('Contact')
    end
  end
end
