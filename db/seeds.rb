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
                   description: Faker::Quote.matz,
                   user_id: User.first.id,
                   short_description: Faker::Quote.famous_last_words,
                   language: Faker::ProgrammingLanguage.name,
                   level: 'Beginner',
                   price: Faker::Number.between(from: 1000, to: 20_000)
                 }])
end

100.times do
  Lesson.create!([{
                   title: Faker::Commerce.product_name,
                   content: Faker::Marketing.buzzwords,
                   course_id: Course.find_by(id: rand(1..29)).id
                 }])
end
PublicActivity.enabled = true

# add friendly_id
User.find_each(&:save)
Course.find_each(&:save)
Lesson.find_each(&:save)
Enrollment.find_each(&:save)

# reset counter_cache
Course.find_each { |course| Course.reset_counters(course.id, :enrollments) }
Course.find_each { |course| Course.reset_counters(course.id, :lessons) }
User.find_each { |u| User.reset_counters(u.id, :courses) }
User.find_each { |u| User.reset_counters(u.id, :enrollments) }
User.find_each { |u| User.reset_counters(u.id, :enrollments) }
