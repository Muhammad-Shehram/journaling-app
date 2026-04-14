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

puts "Cleaning database..."
# The order of destruction matters to avoid foreign key errors!
JournalEntry.destroy_all
Journal.destroy_all
User.destroy_all

puts "Creating test user..."
james = User.create!(
  email: "james@example.com",
  password: "password",
  name: "James"
)

puts "Creating journals..."
[ "Personal Reflections", "Work Project Log", "Travel Diary" ].each do |name|
  journal = Journal.create!(
    name: name,
    user: james
  )

  puts "Creating 5 entries for: #{name}..."
  5.times do
    # Notice: No 'user: james' here anymore!
    # The entry belongs to the journal, and the journal belongs to James.
    journal.journal_entries.create!(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph(sentence_count: 5),
      mood: [ "Happy", "Sad", "Tired", "On Fire" ].sample,
      entry_date: Faker::Date.between(from: 1.month.ago, to: Date.today)
    )
  end
end

puts "✅ Success! James now has 3 journals and 15 total entries."

# puts "Success! Created #{User.count} user, #{Journal.count} journals, and #{JournalEntry.count} entries."
