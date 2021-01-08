# frozen_string_literal: true

if User.find_by_email('admin@example.com').nil?
  admin = User.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456',
                       confirmed_at: Time.now)
  admin.add_role(:admin) unless admin.has_role?(:admin)
end

if User.find_by_email('student@example.com').nil?
  student = User.create!(email: 'student@example.com', password: '123456', password_confirmation: '123456',
                         confirmed_at: Time.now)
  student.add_role(:student) unless student.has_role?(:student)
end

PublicActivity.enabled = false

5.times do
  Course.create!([{
                   title: Faker::Educator.course_name,
                   short_description: Faker::Quote.famous_last_words,
                   description: Faker::TvShows::GameOfThrones.quote,
                   user: User.find_by(email: 'admin@example.com'),
                   language: Faker::ProgrammingLanguage.name,
                   level: 'Beginner',
                   price: 0,
                   approved: true,
                   published: true
                 }])
end

Course.all.each do |course|
  10.times do
    Lesson.create!([{
                     title: Faker::Lorem.sentence(word_count: 3),
                     content: Faker::Lorem.sentence,
                     course: course
                   }])
  end
end

PublicActivity.enabled = true

# update friendly_id
User.find_each(&:save)
Course.find_each(&:save)
Lesson.find_each(&:save)
Enrollment.find_each(&:save)

# update counter_cache
Course.find_each { |course| Course.reset_counters(course.id, :enrollments) }
User.find_each { |user| User.reset_counters(user.id, :courses) }
User.find_each { |user| User.reset_counters(user.id, :enrollments) }
Course.find_each { |course| Course.reset_counters(course.id, :lessons) }
User.find_each { |user| User.reset_counters(user.id, :comments) }
Lesson.find_each { |lesson| Lesson.reset_counters(lesson.id, :comments) }
Tag.find_each { |tag| Tag.reset_counters(tag.id, :course_tags) }
