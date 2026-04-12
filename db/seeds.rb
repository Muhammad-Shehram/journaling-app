# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "--- Cleaning the database... ---"
# Destroying entries first because they belong to users
JournalEntry.destroy_all
User.destroy_all

puts "--- Creating James (Test User)... ---"
james = User.create!(
  name: "James",
  email: "james@journal.com",
  password: "password",
  password_confirmation: "password"
)

puts "--- Generating 5 Journal Entries for James... ---"

moods = [ "😊 Happy", "😔 Sad", "💪 Productive", "🤔 Thoughtful", "😴 Tired", "🌟 Inspired"]

5.times do |i|
  entry = JournalEntry.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    mood: moods.sample,
    entry_date: Faker::Date.between(from: 1.month.ago, to: Date.today),
    user: james
  )
  puts "Created entry #{i + 1}: #{entry.title}"
end

puts "--- Seeding Complete! ---"
puts "Login with: james@journal.com / password"
