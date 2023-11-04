require 'rails_helper'

RSpec.describe "collections/new", type: :view do
  before(:each) do
    assign(:collection, Collection.new(
      title: "MyString",
      description: "MyText",
      rules: "MyText"
    ))
  end

  it "renders new collection form" do
    render

    assert_select "form[action=?][method=?]", collections_path, "post" do

      assert_select "input[name=?]", "collection[title]"

      assert_select "textarea[name=?]", "collection[description]"

      assert_select "textarea[name=?]", "collection[rules]"
    end
  end
end
