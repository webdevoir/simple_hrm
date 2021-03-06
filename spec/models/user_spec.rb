require 'spec_helper'

describe User do

  describe "create user" do

    before do
      @role = create(:role)
    end

    it "should not create a user with invalid attributes" do
      user = User.new
      user.email = "user@simple_hrm"
      user.password = "12345678"
      user.password_confirmation = "12345678"
      user.save.should be_false
      user.should have(1).error_on(:email)
    end

    it "should not create a user without role" do
      user = User.new
      user.email = "user@simple_hrm.com"
      user.password = "12345678"
      user.password_confirmation = "12345678"
      user.save.should be_false
      user.should have(1).error_on(:role_id)
    end

    it "should create a user with role and valid attributes" do
      user = User.new
      user.email = "user@simple_hrm.com"
      user.password = "12345678"
      user.password_confirmation = "12345678"
      user.role = @role
      user.save.should be_true
    end

  end

end
