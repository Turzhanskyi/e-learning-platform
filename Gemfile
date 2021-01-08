# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'active_storage_validations', '0.9.1'
gem 'aws-sdk-s3', '1.87.0', require: false
gem 'bootsnap', '1.5.1', require: false
gem 'chartkick', '3.4.2'
gem 'cocoon', '1.2.15'
gem 'devise', '4.7.3'
gem 'exception_notification', '4.4.3'
gem 'faker', '2.15.1'
gem 'friendly_id', '5.4.1'
gem 'groupdate', '5.2.1'
gem 'haml-rails', '2.0.1'
gem 'image_processing', '1.12.1'
gem 'jbuilder', '2.10.1'
gem 'omniauth-facebook', '8.0.0'
gem 'omniauth-github', github: 'omniauth/omniauth-github', branch: 'master'
gem 'omniauth-google-oauth2', '0.8.1'
gem 'pagy', '3.10.0'
gem 'pg', '1.2.3'
gem 'public_activity', '1.6.4'
gem 'puma', '5.1.1'
gem 'pundit', '2.1.0'
gem 'rails', '6.0.3.4'
gem 'ranked-model', '0.4.6'
gem 'ransack', '2.4.0'
gem 'recaptcha', '5.6.0'
gem 'rolify', '5.3.0'
gem 'sass-rails', '6.0.0'
gem 'simple_form', '5.0.3'
gem 'stripe', '5.29.0'
gem 'turbolinks', '5.2.1'
gem 'webpacker', '5.2.1'
gem 'wicked', '1.3.4'
gem 'wicked_pdf', '2.1.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop-rails', '2.8.1', require: false
end

group :development do
  gem 'listen', '3.3.3'
  gem 'rails-erd', '1.6.0' # sudo apt-get install graphviz; bundle exec erd
  gem 'spring', '2.1.1'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'web-console', '4.1.0'
  gem 'wkhtmltopdf-binary', '0.12.6.5'
end

group :development do
  gem 'wkhtmltopdf-heroku', '2.12.6.0'
end
