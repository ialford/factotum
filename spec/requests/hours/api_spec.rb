require 'spec_helper'

describe "Services" do

  describe "get all services " do

    describe "searching" do
      before(:each) do
        FactoryGirl.create(:service, :code => 'code1')
        FactoryGirl.create(:service, :code => 'code2')
        FactoryGirl.create(:service, :code => 'code3')
      end


      it "returns a array of services and codes you can use " do
        get hours_api_path()
        json = ActiveSupport::JSON.decode(response.body)

        json.class.should be(Hash)
        json["services"].size.should == 3
      end

      it "you can search for lists of services" do
        get hours_api_path(:codes => ['code1', 'code2'])
        json = ActiveSupport::JSON.decode(response.body)
        json["services"].size.should == 2
      end
    end


    describe "dates" do
      before(:each) do
        FactoryGirl.create(:service, :code => 'code', :regular_hours => [
                                                        FactoryGirl.create(:regular_hours, :name => 'School Year Hours', :start_date => 10.days.ago, :end_date => 10.days.from_now),
                                                        FactoryGirl.create(:regular_hours, :name => 'Summer Hours', :start_date => 11.days.from_now, :end_date => 20.days.from_now)
                                                        ])
      end

      it "defaults the date parameter to the current time if none is provided" do
        get hours_api_path()
        json = ActiveSupport::JSON.decode(response.body)

        json["services"]['code']["regular_hours"]["name"].should == "School Year Hours"
        true
      end

      it "uses a passed in date rather then the current time " do
        get hours_api_path(:date => 12.days.from_now)
        json = ActiveSupport::JSON.decode(response.body)
        json["services"]['code']["regular_hours"]["name"].should == "Summer Hours"
      end

    end
  end

end