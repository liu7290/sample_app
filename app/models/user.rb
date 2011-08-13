class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :encrypted_password, :salt
  
  email_regex = /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true,
                   :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex},
                    :uniqueness => true
  validates :password, :confirmation => true,
                       :presence => true,
                       :length => { :within => 6..8 }
                       
  before_save :encrpt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(submitted_email, submitted_password)
    user = find_by_email(submitted_email)
    
    return nil if user.nil?
    
    return user if user.has_password? submitted_password
    
    return nil
  end
  
  private
    def encrpt_password #called when we save record
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string) #called when we compare password
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
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

