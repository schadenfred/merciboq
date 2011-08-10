require 'spec_helper'

describe Thankyou do

  before(:each) do
    @thanker  = Factory(:user)
    @welcomer = Factory(:user, :email => Factory.next(:email),
                               :name  => Factory.next(:name))

    @thankyou = @thanker.thankyous.build(:welcomer_id => @welcomer.id)
  end

  it "should create a new instance given valid attributes" do
    @thankyou.save!
  end

  describe "thanking methods" do

    before(:each) do
      @thankyou.save
    end

    it "should have a thanker attribute" do
      @thankyou.should respond_to(:thanker)
    end

    it "should have the right thanker" do
      @thankyou.thanker.should == @thanker
    end

    it "should have a welcomer attribute" do
      @thankyou.should respond_to(:welcomer)
    end

    it "should have the right welcomer user" do
      @thankyou.welcomer.should == @welcomer
    end
  end

  describe "validations" do

    it "should require a thanker_id" do
      @thankyou.thanker_id = nil
      @thankyou.should_not be_valid
    end

    it "should require a welcomer_id" do
      @thankyou.thanker_id = nil
      @thankyou.should_not be_valid
    end
  end
end
