require 'rails_helper'

RSpec.describe "collection_items/index", type: :view do
  before(:each) do
    assign(:collection_items, [
      CollectionItem.create!(
        title: "Title",
        description: "MyText",
        value: 2,
        height_mm: 3,
        width_mm: 4,
        depth_mm: 5,
        availability: 6,
        images: nil
      ),
      CollectionItem.create!(
        title: "Title",
        description: "MyText",
        value: 2,
        height_mm: 3,
        width_mm: 4,
        depth_mm: 5,
        availability: 6,
        images: nil
      )
    ])
  end

  it "renders a list of collection_items" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(6.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
