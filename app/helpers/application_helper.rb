module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.replace("flash_messages", partial: "layouts/flash_messages")
  end
end
