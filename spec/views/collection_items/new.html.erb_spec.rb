require 'rails_helper'

RSpec.describe "collection_items/new", type: :view do
  before(:each) do
    assign(:collection_item, CollectionItem.new(
      title: "MyString",
      description: "MyText",
      value: 1,
      height_mm: 1,
      width_mm: 1,
      depth_mm: 1,
      availability: 1,
      images: nil
    ))
  end

  it "renders new collection_item form" do
    render

    assert_select "form[action=?][method=?]", collection_items_path, "post" do

      assert_select "input[name=?]", "collection_item[title]"

      assert_select "textarea[name=?]", "collection_item[description]"

      assert_select "input[name=?]", "collection_item[value]"

      assert_select "input[name=?]", "collection_item[height_mm]"

      assert_select "input[name=?]", "collection_item[width_mm]"

      assert_select "input[name=?]", "collection_item[depth_mm]"

      assert_select "input[name=?]", "collection_item[availability]"

      assert_select "input[name=?]", "collection_item[images]"
    end
  end
end
