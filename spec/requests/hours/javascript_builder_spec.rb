require 'spec_helper'

describe "javascript builder" do

  it "returns a functioning page" do
    get hours_javascript_builder_path()
    response.status.should == 200
  end

end