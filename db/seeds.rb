# frozen_string_literal: true

User.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456',
             confirmed_at: Time.now)
User.create!(email: 'student@example.com', password: '123456', password_confirmation: '123456',
             confirmed_at: Time.now)

user = User.find(1)
user.add_role :admin

PublicActivity.enabled = false
30.times do
  Course.create!([{
                   title: Faker::Educator.course_name,
                   description: Faker::TvShows::GameOfThrones.quote,
                   user_id: User.first.id,
                   short_description: Faker::Quote.famous_last_words,
                   language: Faker::ProgrammingLanguage.name,
                   level: 'Beginner',
                   price: Faker::Number.between(from: 1000, to: 20_000)
                 }])
end
PublicActivity.enabled = true

User.find_each(&:save)
Course.find_each(&:save)
