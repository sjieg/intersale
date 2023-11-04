# frozen_string_literal: true

class TabItemComponent < ViewComponent::Base
  def initialize(text:, link:)
    @text = text
    @link = link
  end

  def before_render
    @active = current_page?(@link, check_parameters: true) ? "active" : ""
  end
end
