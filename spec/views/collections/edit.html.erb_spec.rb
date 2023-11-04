require 'rails_helper'

RSpec.describe "collections/edit", type: :view do
  let(:collection) {
    Collection.create!(
      title: "MyString",
      description: "MyText",
      rules: "MyText"
    )
  }

  before(:each) do
    assign(:collection, collection)
  end

  it "renders the edit collection form" do
    render

    assert_select "form[action=?][method=?]", collection_path(collection), "post" do

      assert_select "input[name=?]", "collection[title]"

      assert_select "textarea[name=?]", "collection[description]"

      assert_select "textarea[name=?]", "collection[rules]"
    end
  end
end
