# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'support@e-learning-turvitan.herokuapp.com'
  layout 'mailer'
end
