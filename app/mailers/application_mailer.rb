# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'support@e-learning-platform-turvitan.herokuapp.com'
  layout 'mailer'
end
