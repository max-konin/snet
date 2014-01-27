require 'spec_helper'

describe "tasks/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tasks_path, "post" do
      assert_select "input#task_name[name=?]", "task[name]"
      assert_select "input#task_description[name=?]", "task[description]"
    end
  end
end
