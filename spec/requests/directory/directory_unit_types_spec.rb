require 'spec_helper'

describe "Directory::UnitTypes" do
  describe "GET /directory_unit_types" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get directory_unit_types_path
      response.status.should be(200)
    end
  end
end
