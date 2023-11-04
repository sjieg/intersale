# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create admin users
admin_emails = %w[gijspaulides@gmail.com]
users = []
admin_emails.each do |email|
  users << User.find_or_create_by!(email: email) do |user|
    # Generate random 40 character complex password
    user.password = SecureRandom.base64(40)
    user.skip_confirmation!
    user.admin = true
  end
end
