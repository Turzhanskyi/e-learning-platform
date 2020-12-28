# frozen_string_literal: true

if User.find_by_email('admin@example.com').nil?
  admin = User.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456',
                       confirmed_at: Time.now)
  # admin.skip_confirmation!
  admin.add_role(:admin) unless admin.has_role?(:admin)
end

if User.find_by_email('teacher@example.com').nil?
  teacher = User.create!(email: 'teacher@example.com', password: '123456',
                         password_confirmation: '123456', confirmed_at: Time.now)
  teacher.add_role(:teacher) unless teacher.has_role?(:teacher)
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
                   # price: Faker::Number.between(from: 1000, to: 20000),
                   price: 0,
                   approved: true,
                   published: true
                 }])
end

5.times do
  Course.create!([{
                   title: Faker::Educator.course_name,
                   short_description: Faker::Quote.famous_last_words,
                   description: Faker::TvShows::GameOfThrones.quote,
                   user: User.find_by(email: 'teacher@example.com'),
                   language: Faker::ProgrammingLanguage.name,
                   level: 'Beginner',
                   # price: Faker::Number.between(from: 1000, to: 20000),
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

  Enrollment.create!([{
                       user: User.find_by(email: 'student@example.com'),
                       course: course,
                       price: course.price
                     }])
end

PublicActivity.enabled = true
