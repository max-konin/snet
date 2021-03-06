require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
        :name => "Name",
        :description => "Description"
      ),
      stub_model(Job,
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
