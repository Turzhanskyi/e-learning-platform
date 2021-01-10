# frozen_string_literal: true

if User.find_by_email('turzhansky81@gmail.com').nil?
  admin = User.create!(email: 'turzhansky81@gmail.com', password: '123456', password_confirmation: '123456',
                       confirmed_at: Time.now)
  admin.add_role(:admin) unless admin.has_role?(:admin)
end

if User.find_by_email('student@example.com').nil?
  student = User.create!(email: 'student@example.com', password: '123456', password_confirmation: '123456',
                         confirmed_at: Time.now)
  student.add_role(:student) unless student.has_role?(:student)
end

if User.find_by_email('teacher@example.com').nil?
  teacher = User.create!(email: 'teacher@example.com', password: '123456',
                         password_confirmation: '123456', confirmed_at: Time.now)
  teacher.add_role(:teacher) unless teacher.has_role?(:teacher)
end

PublicActivity.enabled = false

5.times do
  Course.create!([{
                   title: Faker::Educator.course_name,
                   marketing_description: Faker::Quote.famous_last_words,
                   description: Faker::TvShows::GameOfThrones.quote,
                   user: User.find_by(email: 'turzhansky81@gmail.com'),
                   language: Faker::ProgrammingLanguage.name,
                   level: 'Beginner',
                   price: Faker::Number.between(from: 0, to: 20_000),
                   approved: true,
                   published: true
                 }])
end

5.times do
  Course.create!([{
                   title: Faker::Educator.course_name,
                   marketing_description: Faker::Quote.famous_last_words,
                   description: Faker::TvShows::GameOfThrones.quote,
                   user: User.find_by(email: 'teacher@example.com'),
                   language: Faker::ProgrammingLanguage.name,
                   level: 'Beginner',
                   price: Faker::Number.between(from: 0, to: 20_000),
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

  Enrollment.create!([{
                       user: User.find_by(email: 'student@example.com'),
                       course: course,
                       price: course.price
                     }])
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

# tracked owner
proc { |controller, _model| controller.current_user }
