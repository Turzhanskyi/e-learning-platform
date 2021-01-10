# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'E-learn <support@e-learn.turvitan.km.ua>'
  layout 'mailer'
end
