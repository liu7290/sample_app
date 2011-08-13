require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Example User", 
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"      
    }
  end
  
  it "should create a new instance given valid attributes" do
    User.create(@attr)
  end
  
  it "should have a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.valid?.should_not == true
  end

  it "should have a email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject too long name" do
    long_name = "a" * 100
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should reject invalid email" do
    invalid_emails = %w[user@foo,com user_at_foo.org user@foo.]
    invalid_emails.each do |email|
      invalid_email_user = User.new(@attr.merge(:email => email))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end
    
    it "should require a matching password" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end

    it "should reject a short password" do
      User.new(@attr.merge(:password => "blaba", :password_confirmation => "blaba")).
      should_not be_valid
    end

    it "should reject a short password" do
      User.new(@attr.merge(:password => "blabababa", :password_confirmation => "blabababa")).
      should_not be_valid
    end
  end
  
  describe  "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the password don't match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil;
      end

      it "should return nil on invalid eamil" do
        wrong_password_user = User.authenticate("bar@foo.com", @attr[:password])
        wrong_password_user.should be_nil;
      end
      
      it "should return object on email/password match" do
        wrong_password_user = User.authenticate(@attr[:email], @attr[:password])
        wrong_password_user.should == @user;
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

