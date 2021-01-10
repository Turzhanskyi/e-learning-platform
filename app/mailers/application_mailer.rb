# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'e-learn-turvitan <support@e-learn.turvitan.km.ua>'
  layout 'mailer'
end
