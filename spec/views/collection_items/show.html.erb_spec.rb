require 'rails_helper'

RSpec.describe "collection_items/show", type: :view do
  before(:each) do
    assign(:collection_item, CollectionItem.create!(
      title: "Title",
      description: "MyText",
      value: 2,
      height_mm: 3,
      width_mm: 4,
      depth_mm: 5,
      availability: 6,
      images: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(//)
  end
end
