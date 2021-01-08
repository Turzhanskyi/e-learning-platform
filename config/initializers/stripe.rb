# frozen_string_literal: true

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.dig(:stripe, :publishable).to_s,
  secret_key: Rails.application.credentials.dig(:stripe, :secret).to_s
}
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret).to_s
