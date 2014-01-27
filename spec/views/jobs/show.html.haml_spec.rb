require 'spec_helper'

describe "tasks/show" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
  end
end
