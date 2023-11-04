module UsersHelper
  def gravatar_for(user, options = {size: 80})
    size = options[:size]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
    # image_tag(gravatar_url, alt: user.name, class: "gravatar")
    image_tag(gravatar_url, alt: user.email, title: user.email, class: "gravatar rounded-circle", data: {
      controller: "tooltip"
    })
  end
end
