require 'spec_helper'

describe "Directory::OrganizationalUnits" do
  describe "GET /directory_organizational_units" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get directory_organizational_units_path
      response.status.should be(200)
    end
  end
end