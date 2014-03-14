require 'spec_helper'

describe Directory::Admin::EmployeesController do

  let(:directory_employee) { FactoryGirl.create(:directory_employee) }

  before do
    login_user
  end

  describe :new do

    it "returns a successful response" do
      controller.stub('check_current_user_can_add!').and_return(true)
      get :new
      response.should be_success
    end

    it "returns a not successful response for non admin" do
      get :new
      response.should_not be_success
    end

  end


  describe :edit do

    it "returns a successful response" do
      controller.stub('check_current_user_can_edit_this!').and_return(true)
      get :edit, id: directory_employee.id
      response.should be_success
    end


    it "returns a not successful response for non admin" do
      get :edit, id: directory_employee.id
      response.should_not be_success
    end

  end


end

