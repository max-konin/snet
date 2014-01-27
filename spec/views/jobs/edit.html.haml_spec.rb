require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", task_path(@job), "post" do
      assert_select "input#task_name[name=?]", "task[name]"
      assert_select "input#task_description[name=?]", "task[description]"
    end
  end
end
