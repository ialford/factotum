require "spec_helper"

describe "availability/service_points/edit.html.erb" do
  let(:service_point) {
    FactoryGirl.create(:service_point, :regular_hours => [ current_hours] )
  }

  let(:current_hours) {
    FactoryGirl.create(:regular_hours)
  }

  it "displays the edit form" do
    allow(view).to receive(:options_for_unit_select).and_return([])
    allow(view).to receive(:options_for_person_select).and_return([])

    assign(:service_point, service_point)
    controller.request.path_parameters[:id] = service_point.id

    render

    expect(rendered).to match /form/
  end
end
