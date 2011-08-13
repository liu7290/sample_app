require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Example User", :email => "user@example.com" }
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

