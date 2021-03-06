require 'spec_helper'

describe UsersController do

  before(:each) do
    @new_user_attr = {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      subdomain: Faker::Name.name.gsub(/\s/, "-").gsub(/[^\w-]/, '').downcase,
      password: "foobar",
      password_confirmation: "foobar"
    }
  end

  it "should create a new instance given a valid attribute" do
    user = FactoryGirl.create(:user)
    user.should be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@new_user_attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@new_user_attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@new_user_attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@new_user_attr)
    user_with_duplicate_email = User.new(@new_user_attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @new_user_attr[:email].upcase
    User.create!(@new_user_attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@new_user_attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@new_user_attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    let(:user) { Factory.build(:user) }
    
#    before(:each) do
#      @user = User.new(@new_user_attr)
#    end
#    @new_user_attr
#    it "should require a password" do
#      User.create(@attr.merge(:password => "", :password_confirmation => "")).
#        should_not be_valid
#      end
#    end

#    it "should require a matching password confirmation" do
#      User.new(@attr.merge(:password_confirmation => "invalid")).
#        should_not be_valid
#    end

#    it "should reject short passwords" do
#      short = "a" * 5
#      hash = @attr.merge(:password => short, :password_confirmation => short)
#      User.new(hash).should_not be_valid
#    end

#    it "should reject long passwords" do
#      long = "a" * 41
#      hash = @attr.merge(:password => long, :password_confirmation => long)
#      User.new(hash).should_not be_valid
#    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@new_user_attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
 #     @user.encrypted_password.should_not be_blank
    end
  end

  describe "thankyous" do

    before(:each) do
      @user = User.create!(@new_user_attr)
      @welcomer = FactoryGirl.create(:user)
      content = "content_for_thankyou"
      headline = "headline_for_thankyou"
      @new_user_attr = { :content => "lorem ipsum" }
    end

    it "should have a thankyous method" do
      @user.should respond_to(:thankyous)
    end

    it "should have a thanked method" do
      @user.should respond_to(:thanked)
    end

    it "should have a thanked? method" do
      @user.should respond_to(:thanked?)
    end

    it "should have a welcomes method" do
      @user.should respond_to(:welcomes)
    end

    it "should have a welcomed method" do
      @user.should respond_to(:welcomed)
    end
  end

  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@new_user_attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
end

#  describe "DELETE 'destroy'" do

#    let(:user) { Factory(:user) }

#    describe "as a non-signed-in user" do
#
#      it "should deny access" do
#        delete :destroy, id: @user
#        response.should redirect_to(signin_path)
#      end
#    end

#    describe "as a regular, non-admin user" do
#      it "shoudl protect the page" do
#        sign_in(@user)
#        delete :destroy, id: @user
#        response.should redirect_to(root_path)
#      end
#    end

#    describe "as an admin user" do

#      let(:user) { Factory(:user, admin: true) }
#      sign_in(user)
#    end
#  end
# end

