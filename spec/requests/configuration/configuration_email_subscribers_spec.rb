require 'spec_helper'

describe "Configuration::EmailSubscribers" do
  describe "GET /configuration_email_subscribers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get configuration_email_subscribers_path
      response.status.should be(200)
    end
  end
end
