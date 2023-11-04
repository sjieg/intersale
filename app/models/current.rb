class Current < ActiveSupport::CurrentAttributes
  attribute :user, :locale

  # @return [User]
  def user
    super
  end

  # @return [String]
  def locale
    super
  end

  # Example to set other attributes on the Current.user
  # def user=(user)
  #   super
  #   self.account = user.account
  #   Time.zone    = user.time_zone
  # end
end
