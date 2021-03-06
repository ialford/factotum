require 'rails_helper'

describe DirectoryContactFax do

  describe "validations" do


    let(:directory_employee_status) { FactoryGirl.create(:directory_employee_status) }
    let(:directory_employee_rank) { FactoryGirl.create(:directory_employee_rank) }
    let(:directory_employee) { FactoryGirl.create(:directory_employee, {status_id: directory_employee_status.id, rank_id: directory_employee_rank.id}) }


    let(:valid_params) { { contact_information: "631-9000" } }
    let(:letter_params) { { contact_information: "dfdfsd" } }
    let(:number_params) { { contact_information: "3333" } }

    it "saves with valid params" do
      expect(directory_employee.faxes.new(valid_params).save).to be_truthy
    end


    it "is invalid with just letters" do
      expect(directory_employee.faxes.new(letter_params)).not_to be_valid
    end


    it "is invalid with wrong number of numbers" do
      expect(directory_employee.faxes.new(number_params)).not_to be_valid
    end

  end

end
