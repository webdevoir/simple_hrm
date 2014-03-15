require 'spec_helper'

describe "organization/organization_locations/index" do
  before(:each) do
    assign(:organization_organization_locations, [
      stub_model(Organization::OrganizationLocation,
        :name => "Name",
        :number_of_employees => 1
      ),
      stub_model(Organization::OrganizationLocation,
        :name => "Name",
        :number_of_employees => 1
      )
    ])
  end

  it "renders a list of organization/organization_locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
